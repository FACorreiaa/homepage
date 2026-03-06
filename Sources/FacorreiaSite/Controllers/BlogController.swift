import Vapor

struct BlogController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let blogGroup = routes.grouped("blog")
        blogGroup.get(use: index)
        blogGroup.get(":slug", use: showPost)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        // Asynchronously trigger IP recording
        await BlogTracker.shared.recordVisit(req: req)

        // Fetch current snapshot of views
        let stats = await BlogTracker.shared.getDisplayStats()

        // Build the view objects
        let context = BlogContext(
            title: "Blog | FC Software Studio",
            activePage: "blog",
            topics: [
                "Go & Backend",
                "React & Mobile",
                "System Design",
                "Building in Public",
                "DevOps",
                "iOS Development",
            ],
            totalViews: stats.views,
            flags: stats.flagList.map { FlagStat(emoji: $0.flag, count: $0.count) }
        )

        return try await req.view.render("blog", context)
    }

    @Sendable
    func showPost(req: Request) async throws -> View {
        guard let slug = req.parameters.get("slug"), slug == "learning-ios" else {
            throw Abort(.notFound)
        }

        // Setup individual post context
        let context = BlogPostContext(
            title: "Transitioning from Go to iOS | FC Software Studio",
            activePage: "blog",
            post: BlogPostItem(
                title: "From Go to iOS: Unlearning the Backend to Master SwiftUI",
                summary:
                    "How shifting from imperative, backend programming in Go to declarative, reactive UI in Swift unlocked a new level of product engineering.",
                category: "iOS Development",
                dateRaw: "2026-02-01",
                dateFormatted: "Feb 1, 2026"
            )
        )

        return try await req.view.render("blog-post", context)
    }
}

// MARK: - View Models

struct BlogContext: Content {
    let title: String
    let activePage: String
    let topics: [String]
    let totalViews: Int
    let flags: [FlagStat]
}

struct FlagStat: Content {
    let emoji: String
    let count: Int
}

struct BlogPostContext: Content {
    let title: String
    let activePage: String
    let post: BlogPostItem
}

struct BlogPostItem: Content {
    let title: String
    let summary: String
    let category: String
    let dateRaw: String
    let dateFormatted: String
}
