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

    // Static file middleware with caching
    let publicDirectory = app.directory.publicDirectory
    app.middleware.use(FileMiddleware(publicDirectory: publicDirectory))
    
    // Custom middleware to add Cache-Control headers to static assets
    app.middleware.use(CacheControlMiddleware())

    app.views.use(.leaf)
    app.leaf.tags["unsafeRaw"] = UnsafeRawTag()

    // register routes
    try routes(app)
}

struct CacheControlMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        let response = try await next.respond(to: request)
        
        // Only add headers to successful responses for static assets
        let path = request.url.path
        if response.status == .ok && (
            path.hasSuffix(".css") || 
            path.hasSuffix(".js") || 
            path.hasSuffix(".png") || 
            path.hasSuffix(".jpg") || 
            path.hasSuffix(".jpeg") || 
            path.hasSuffix(".svg") || 
            path.hasSuffix(".woff2") ||
            path.hasSuffix(".json")
        ) {
            response.headers.replaceOrAdd(name: .cacheControl, value: "public, max-age=31536000, immutable")
        }
        
        return response
    }
}
