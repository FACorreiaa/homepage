import Vapor
import Ink

struct BookmarksController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let bookmarks = routes.grouped("bookmarks")
        bookmarks.get(use: index)
        bookmarks.get(":slug", use: show)

        routes.get("api", "graph", use: graphData)
    }

    // MARK: - Vault Scanning

    /// Base vault path (the symlink root)
    private func vaultBase(for req: Request) -> String {
        return req.application.directory.publicDirectory + "vault/"
    }

    /// Only scan /raw as specified
    private let scanDirs = ["raw"]

    /// Recursively find all .md files in the vault, returning (slug, relativePath, fullPath, category)
    private func discoverFiles(for req: Request) throws -> [VaultFile] {
        let base = vaultBase(for: req)
        let fm = FileManager.default
        var results: [VaultFile] = []
        var seenSlugs = Set<String>()

        for dir in scanDirs {
            let dirPath = base + dir + "/"
            guard fm.fileExists(atPath: dirPath) else { continue }

            // Resolve symlinks so path comparison works correctly
            let resolvedDirURL = URL(fileURLWithPath: dirPath).resolvingSymlinksInPath()
            let resolvedDirPath = resolvedDirURL.path + (resolvedDirURL.path.hasSuffix("/") ? "" : "/")

            guard let enumerator = fm.enumerator(
                at: resolvedDirURL,
                includingPropertiesForKeys: [.isRegularFileKey],
                options: [.skipsHiddenFiles]
            ) else { continue }

            while let fileURL = enumerator.nextObject() as? URL {
                let path = fileURL.path
                guard path.hasSuffix(".md") else { continue }

                // Skip syncthing temp/conflict files
                let filename = fileURL.lastPathComponent
                if filename.contains(".sync-conflict") ||
                   filename.hasPrefix(".syncthing.") ||
                   filename.hasSuffix(".tmp") {
                    continue
                }

                // Build relative path using the resolved base
                let relativePath = String(path.dropFirst(resolvedDirPath.count))

                // Category = first path component (directory name)
                let pathComponents = relativePath.split(separator: "/")
                let category: String
                if pathComponents.count > 1 {
                    category = String(pathComponents[0])
                } else {
                    category = "Uncategorized"
                }

                let baseName = filename.replacingOccurrences(of: ".md", with: "")
                let slug = slugify(baseName)

                // Skip duplicates
                guard !seenSlugs.contains(slug) else { continue }
                seenSlugs.insert(slug)

                results.append(VaultFile(
                    slug: slug,
                    name: baseName,
                    category: category,
                    fullPath: path,
                    sourceDir: dir
                ))
            }
        }

        return results
    }

    /// Convert a name to a URL-safe slug
    private func slugify(_ name: String) -> String {
        return name
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "%20", with: "-") ?? name.lowercased()
    }

    /// Build sidebar data grouped by category
    private func buildSidebar(from files: [VaultFile]) -> [SidebarCategory] {
        var grouped: [String: [SidebarItem]] = [:]
        for file in files {
            let item = SidebarItem(slug: file.slug, name: file.name)
            grouped[file.category, default: []].append(item)
        }
        // Sort categories alphabetically, items alphabetically within
        return grouped.map { category, items in
            SidebarCategory(
                name: category,
                items: items.sorted { $0.name.lowercased() < $1.name.lowercased() }
            )
        }.sorted { $0.name.lowercased() < $1.name.lowercased() }
    }

    // MARK: - Routes

    @Sendable
    func index(req: Request) async throws -> View {
        let files = try discoverFiles(for: req)
        let sidebar = buildSidebar(from: files)

        let context = BookmarksContext(
            title: "Bookmarks | FC Software Studio",
            activePage: "bookmarks",
            seoDescription: "A digital garden and knowledge graph of my Obsidian notes, insights, and bookmarks.",
            categories: sidebar,
            totalNotes: files.count
        )
        return try await req.view.render("bookmarks", context)
    }

    @Sendable
    func show(req: Request) async throws -> View {
        guard let slug = req.parameters.get("slug") else {
            throw Abort(.badRequest)
        }

        let files = try discoverFiles(for: req)
        guard let file = files.first(where: { $0.slug == slug.lowercased() }) else {
            throw Abort(.notFound)
        }

        guard let content = try? String(contentsOfFile: file.fullPath, encoding: .utf8) else {
            throw Abort(.notFound)
        }

        // Strip YAML frontmatter if present
        let cleanedContent = stripFrontmatter(content)

        var parser = MarkdownParser()

        // Custom modifier for [[wikilinks]]
        let wikilinkModifier = Modifier(target: .paragraphs) { html, markdown in
            let regex = try! NSRegularExpression(
                pattern: "\\[\\[([^\\]|]+)(?:\\|([^\\]]+))?\\]\\]",
                options: []
            )
            let range = NSRange(markdown.startIndex..<markdown.endIndex, in: markdown)

            var result = String(markdown)
            let matches = regex.matches(in: String(markdown), options: [], range: range).reversed()

            for match in matches {
                let targetRange = Range(match.range(at: 1), in: String(markdown))!
                let target = String(markdown[targetRange])

                let display: String
                if let displayRange = Range(match.range(at: 2), in: String(markdown)) {
                    display = String(markdown[displayRange])
                } else {
                    display = target
                }

                let linkSlug = target.lowercased().replacingOccurrences(of: " ", with: "-")
                let link = "<a href=\"/bookmarks/\(linkSlug)\" class=\"wikilink\">\(display)</a>"

                let matchRange = Range(match.range, in: result)!
                result.replaceSubrange(matchRange, with: link)
            }

            return result
        }

        parser.addModifier(wikilinkModifier)

        let result = parser.parse(cleanedContent)
        let title = result.metadata["title"] ?? file.name

        let sidebar = buildSidebar(from: files)

        let context = BookmarkPostContext(
            title: "\(title) | Bookmarks",
            activePage: "bookmarks",
            post: BookmarkItem(
                title: title,
                htmlContent: result.html,
                category: file.category
            ),
            categories: sidebar,
            currentSlug: slug
        )

        return try await req.view.render("bookmark-post", context)
    }

    @Sendable
    func graphData(req: Request) async throws -> GraphData {
        let files = try discoverFiles(for: req)
        var nodes: [GraphNode] = []
        var links: [GraphLink] = []
        let nodeIds = Set(files.map { $0.slug })

        // Group by category to assign visual grouping
        var categoryIndex: [String: Int] = [:]
        var nextGroup = 0

        for file in files {
            if categoryIndex[file.category] == nil {
                categoryIndex[file.category] = nextGroup
                nextGroup += 1
            }
            let group = categoryIndex[file.category] ?? 0
            nodes.append(GraphNode(id: file.slug, name: file.name, val: 1, group: group, category: file.category))
        }

        // Parse wikilinks for edges
        let regex = try NSRegularExpression(
            pattern: "\\[\\[([^\\]|]+)(?:\\|([^\\]]+))?\\]\\]",
            options: []
        )

        for file in files {
            guard let content = try? String(contentsOfFile: file.fullPath, encoding: .utf8) else {
                continue
            }

            let range = NSRange(content.startIndex..<content.endIndex, in: content)
            let matches = regex.matches(in: content, options: [], range: range)

            for match in matches {
                guard let targetRange = Range(match.range(at: 1), in: content) else { continue }
                let targetName = String(content[targetRange])
                let targetId = targetName.lowercased().replacingOccurrences(of: " ", with: "-")

                if nodeIds.contains(targetId) && targetId != file.slug {
                    links.append(GraphLink(source: file.slug, target: targetId))
                }
            }
        }

        return GraphData(nodes: nodes, links: links)
    }

    // MARK: - Helpers

    private func stripFrontmatter(_ content: String) -> String {
        // Strip YAML frontmatter (--- ... ---)
        if content.hasPrefix("---") {
            let lines = content.components(separatedBy: "\n")
            var endIndex = -1
            for i in 1..<lines.count {
                if lines[i].trimmingCharacters(in: .whitespaces) == "---" {
                    endIndex = i
                    break
                }
            }
            if endIndex > 0 {
                return lines[(endIndex + 1)...].joined(separator: "\n")
            }
        }
        return content
    }
}

// MARK: - Models

struct VaultFile {
    let slug: String
    let name: String
    let category: String
    let fullPath: String
    let sourceDir: String
}

struct SidebarItem: Content {
    let slug: String
    let name: String
}

struct SidebarCategory: Content {
    let name: String
    let items: [SidebarItem]
}

struct BookmarksContext: Content {
    let title: String
    let activePage: String
    let seoDescription: String
    let categories: [SidebarCategory]
    let totalNotes: Int
}

struct BookmarkPostContext: Content {
    let title: String
    let activePage: String
    let post: BookmarkItem
    let categories: [SidebarCategory]
    let currentSlug: String
}

struct BookmarkItem: Content {
    let title: String
    let htmlContent: String
    let category: String
}

struct GraphData: Content {
    let nodes: [GraphNode]
    let links: [GraphLink]
}

struct GraphNode: Content {
    let id: String
    let name: String
    let val: Int
    let group: Int
    let category: String
}

struct GraphLink: Content {
    let source: String
    let target: String
}
