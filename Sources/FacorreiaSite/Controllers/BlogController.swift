import Foundation
import Ink
import Vapor

struct BlogController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let blogGroup = routes.grouped("blog")
        blogGroup.get(use: index)
        blogGroup.get(":slug", use: showPost)
    }

    private func getAllPosts(req: Request) -> [BlogPostItem] {
        let blogDir = req.application.directory.publicDirectory + "content/blog/"
        var posts: [BlogPostItem] = []

        guard let files = try? FileManager.default.contentsOfDirectory(atPath: blogDir) else {
            return []
        }

        let parser = MarkdownParser()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium

        for file in files where file.hasSuffix(".md") {
            let slug = file.replacingOccurrences(of: ".md", with: "")
            let path = blogDir + file
            guard let content = try? String(contentsOfFile: path, encoding: .utf8) else { continue }

            let result = parser.parse(content)

            let title = result.metadata["title"] ?? "Untitled"
            let summary = result.metadata["summary"] ?? ""
            let category = result.metadata["category"] ?? "Uncategorized"
            let dateRaw = result.metadata["date"] ?? "2026-01-01"

            var dateFormatted = dateRaw
            if let date = dateFormatter.date(from: dateRaw) {
                dateFormatted = displayFormatter.string(from: date)
            }

            posts.append(
                BlogPostItem(
                    slug: slug,
                    title: title,
                    summary: summary,
                    category: category,
                    dateRaw: dateRaw,
                    dateFormatted: dateFormatted,
                    htmlContent: result.html
                ))
        }

        // Sort descending by date
        return posts.sorted { $0.dateRaw > $1.dateRaw }
    }

    @Sendable
    func index(req: Request) async throws -> View {
        // Asynchronously trigger IP recording
        await BlogTracker.shared.recordVisit(req: req)

        // Fetch current snapshot of views
        let stats = await BlogTracker.shared.getDisplayStats()

        let posts = getAllPosts(req: req)

        // Build the view objects
        let context = BlogContext(
            title: "Blog | FC Software Studio",
            activePage: "blog",
            seoDescription:
                "Exploring software architecture, iOS development, backend scale using Swift, and the journey of building a solo engineering studio.",
            ogImage: "https://facorreia.com/images/og-blog-index.png",
            topics: [
                "Go & Backend",
                "React & Mobile",
                "System Design",
                "Building in Public",
                "DevOps",
                "iOS Development",
            ],
            totalViews: stats.views,
            flags: stats.flagList.map { FlagStat(emoji: $0.flag, count: $0.count) },
            posts: posts
        )

        return try await req.view.render("blog", context)
    }

    @Sendable
    func showPost(req: Request) async throws -> View {
        guard let slug = req.parameters.get("slug") else {
            throw Abort(.badRequest)
        }

        let posts = getAllPosts(req: req)
        guard let post = posts.first(where: { $0.slug == slug }) else {
            throw Abort(.notFound)
        }

        // Setup individual post context
        let context = BlogPostContext(
            title: "\(post.title) | FC Software Studio",
            activePage: "blog",
            seoDescription: post.summary,
            ogImage: "https://facorreia.com/images/og-blog-\(post.slug + "").png",
            ogType: "article",
            post: post
        )

        return try await req.view.render("blog-post", context)
    }
}

// MARK: - View Models

struct BlogContext: Content {
    let title: String
    let activePage: String
    var seoDescription: String?
    var ogImage: String?
    let topics: [String]
    let totalViews: Int
    let flags: [FlagStat]
    let posts: [BlogPostItem]
}

struct FlagStat: Content {
    let emoji: String
    let count: Int
}

struct BlogPostContext: Content {
    let title: String
    let activePage: String
    var seoDescription: String?
    var ogImage: String?
    var ogType: String?
    let post: BlogPostItem
}

struct BlogPostItem: Content {
    let slug: String
    let title: String
    let summary: String
    let category: String
    let dateRaw: String
    let dateFormatted: String
    let htmlContent: String
}
