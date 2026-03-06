import Vapor

struct BlogController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("blog", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
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
            ]
        )

        return try await req.view.render("blog", context)
    }
}

// MARK: - View Models

struct BlogContext: Content {
    let title: String
    let activePage: String
    let topics: [String]
}
