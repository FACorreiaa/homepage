import Fluent
import Vapor

struct CreateClientUser: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("client_users")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .unique(on: "email")
            .field("password_hash", .string, .required)
            .field("project_status", .string, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("client_users").delete()
    }
}

/// A bootstrap migration to ensure Fernando can always login to the Admin dashboard securely
struct SeedAdminUser: AsyncMigration {
    func prepare(on database: any Database) async throws {
        let password = try Bcrypt.hash("StudioAdmin123!")  // Extremely hardcoded for demo scaffolding!

        let admin = ClientUser(
            name: "Fernando Correia",
            email: "fernandocorreia316@gmail.com",
            passwordHash: password,
            projectStatus: "System Administrator"
        )
        try await admin.save(on: database)
    }

    func revert(on database: any Database) async throws {
        try await ClientUser.query(on: database).filter(\.$email == "fernandocorreia316@gmail.com")
            .delete()
    }
}
