import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Render HTML for thrown errors instead of Vapor's default JSON payload.
    app.middleware.use(ErrorPageMiddleware())

    // Serve static files (CSS, JS, images) from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
