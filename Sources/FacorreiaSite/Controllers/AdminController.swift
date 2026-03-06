import Fluent
import Vapor

struct AdminController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let authGroup = routes.grouped("admin")

        // Public Login routes
        authGroup.get("login", use: loginPage)
        authGroup.post("login", use: loginHandler)

        // Protected Admin routes (Requires a valid Session Token in cookies)
        let protected = authGroup.grouped(
            ClientUser.sessionAuthenticator(), ClientUser.redirectMiddleware(path: "/admin/login"))

        protected.get("dashboard", use: dashboard)
        protected.post("logout", use: logout)
    }

    @Sendable
    func loginPage(req: Request) async throws -> View {
        return try await req.view.render(
            "login", ["title": "Portal Login | FC Software Studio", "activePage": "admin"])
    }

    @Sendable
    func loginHandler(req: Request) async throws -> Response {
        let user = try req.content.decode(LoginData.self)

        // Find user by email and securely verify BCrypt hashed DB string against raw form input
        if let storedUser = try await ClientUser.query(on: req.db)
            .filter(\.$email == user.email)
            .first(),
            try Bcrypt.verify(user.password, created: storedUser.passwordHash)
        {

            req.session.authenticate(storedUser)
            return req.redirect(to: "/admin/dashboard")
        }

        // If login failed
        return try await req.view.render(
            "login",
            [
                "title": "Portal Login", "activePage": "admin",
                "error": "Invalid credentials or unauthorized account.",
            ]
        ).encodeResponse(for: req)
    }

    @Sendable
    func dashboard(req: Request) async throws -> View {
        // Safe to explicitly unwrap because `redirectMiddleware` blocks unauthenticated users entirely
        let user = try req.auth.require(ClientUser.self)

        // Only load leads if an admin is logged in (could be scoped by role later)
        let leads = try await ProposalLead.query(on: req.db).sort(\.$createdAt, .descending).all()

        return try await req.view.render(
            "dashboard",
            DashboardContext(
                title: "Client Dashboard",
                activePage: "admin",
                user: user,
                leads: leads
            ))
    }

    @Sendable
    func logout(req: Request) async throws -> Response {
        req.auth.logout(ClientUser.self)
        req.session.destroy()  // Invalidate entirely to prevent hijacking
        return req.redirect(to: "/")
    }
}

// MARK: - View Models

struct LoginData: Content {
    let email: String
    let password: String
}

struct DashboardContext: Content {
    let title: String
    let activePage: String
    let user: ClientUser
    let leads: [ProposalLead]
}
