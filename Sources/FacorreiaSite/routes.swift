import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render(
            "index",
            [
                "title": "FC Software Studio",
                "activePage": "home",
            ])
    }

    try app.register(collection: AboutController())
}
