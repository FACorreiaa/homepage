import Vapor
import Ink

struct BookmarksController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let bookmarks = routes.grouped("bookmarks")
        bookmarks.get(use: index)
        bookmarks.get(":slug", use: show)

        routes.get("api", "graph", use: graphData)
    }
    
    private func vaultPath(for req: Request) -> String {
        return req.application.directory.publicDirectory + "vault/wiki/"
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = BookmarksContext(
            title: "Bookmarks | FC Software Studio",
            activePage: "bookmarks",
            seoDescription: "A digital garden and knowledge graph of my Obsidian notes, insights, and bookmarks."
        )
        return try await req.view.render("bookmarks", context)
    }

    @Sendable
    func show(req: Request) async throws -> View {
        guard let slug = req.parameters.get("slug") else {
            throw Abort(.badRequest)
        }
        
        let path = vaultPath(for: req)
        
        // Find file by slug (case insensitive match if possible, or just exact match)
        let files = try FileManager.default.contentsOfDirectory(atPath: path)
        guard let fileName = files.first(where: { $0.lowercased().replacingOccurrences(of: " ", with: "-") == slug.lowercased() + ".md" }) else {
            throw Abort(.notFound)
        }
        
        let filePath = path + fileName
        guard let content = try? String(contentsOfFile: filePath, encoding: .utf8) else {
            throw Abort(.notFound)
        }
        
        var parser = MarkdownParser()
        
        // Custom modifier for [[wikilinks]]
        let wikilinkModifier = Modifier(target: .paragraphs) { html, markdown in
            let regex = try! NSRegularExpression(pattern: "\\[\\[([^\\]|]+)(?:\\|([^\\]]+))?\\]\\]", options: [])
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
                
                let slug = target.lowercased().replacingOccurrences(of: " ", with: "-")
                let link = "<a href=\"/bookmarks/\(slug)\" class=\"wikilink\">\(display)</a>"
                
                let matchRange = Range(match.range, in: result)!
                result.replaceSubrange(matchRange, with: link)
            }
            
            return result
        }
        
        parser.addModifier(wikilinkModifier)
        
        let result = parser.parse(content)
        let title = result.metadata["title"] ?? fileName.replacingOccurrences(of: ".md", with: "").replacingOccurrences(of: "-", with: " ").capitalized
        
        let context = BookmarkPostContext(
            title: "\(title) | Bookmarks",
            activePage: "bookmarks",
            post: BookmarkItem(
                title: title,
                htmlContent: result.html
            )
        )
        
        return try await req.view.render("bookmark-post", context)
    }

    @Sendable
    func graphData(req: Request) async throws -> GraphData {
        let path = vaultPath(for: req)
        let files = try FileManager.default.contentsOfDirectory(atPath: path)
        var nodes: [GraphNode] = []
        var links: [GraphLink] = []
        var nodeIds = Set<String>()
        
        for file in files where file.hasSuffix(".md") {
            let id = file.replacingOccurrences(of: ".md", with: "").lowercased().replacingOccurrences(of: " ", with: "-")
            let name = file.replacingOccurrences(of: ".md", with: "").replacingOccurrences(of: "-", with: " ").capitalized
            nodes.append(GraphNode(id: id, name: name, val: 1))
            nodeIds.insert(id)
        }
        
        for file in files where file.hasSuffix(".md") {
            let sourceId = file.replacingOccurrences(of: ".md", with: "").lowercased().replacingOccurrences(of: " ", with: "-")
            let content = try String(contentsOfFile: path + file, encoding: .utf8)
            
            let regex = try NSRegularExpression(pattern: "\\[\\[([^\\]|]+)(?:\\|([^\\]]+))?\\]\\]", options: [])
            let range = NSRange(content.startIndex..<content.endIndex, in: content)
            let matches = regex.matches(in: content, options: [], range: range)
            
            for match in matches {
                let targetRange = Range(match.range(at: 1), in: content)!
                let targetName = String(content[targetRange])
                let targetId = targetName.lowercased().replacingOccurrences(of: " ", with: "-")
                
                if nodeIds.contains(targetId) {
                    links.append(GraphLink(source: sourceId, target: targetId))
                }
            }
        }
        
        return GraphData(nodes: nodes, links: links)
    }
}

struct BookmarksContext: Content {
    let title: String
    let activePage: String
    let seoDescription: String
}

struct BookmarkPostContext: Content {
    let title: String
    let activePage: String
    let post: BookmarkItem
}

struct BookmarkItem: Content {
    let title: String
    let htmlContent: String
}

struct GraphData: Content {
    let nodes: [GraphNode]
    let links: [GraphLink]
}

struct GraphNode: Content {
    let id: String
    let name: String
    let val: Int
}

struct GraphLink: Content {
    let source: String
    let target: String
}
