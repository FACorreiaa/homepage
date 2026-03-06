import Vapor

struct PlayController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("play", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = PlayContext(
            title: "Play Snake | FC Software Studio",
            activePage: "play"
        )
        return try await req.view.render("play", context)
    }
}

// MARK: - View Models

struct PlayContext: Content {
    let title: String
    let activePage: String
}
