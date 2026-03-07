import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Configure SQLite Database
    let dbPath = Environment.get("DATABASE_PATH") ?? "studio.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)

    // Auto-migrate the databases incrementally on boot
    app.migrations.add(CreateProposalLead())
    app.migrations.add(CreateClientUser())
    app.migrations.add(SeedAdminUser())
    try await app.autoMigrate()

    // Enact HTTP Cookie sessions application-wide
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.views.use(.leaf)
    app.leaf.tags["unsafeRaw"] = UnsafeRawTag()

    // register routes
    try routes(app)
}
