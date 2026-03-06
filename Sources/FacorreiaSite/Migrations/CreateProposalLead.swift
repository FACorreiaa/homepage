import Fluent

struct CreateProposalLead: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("proposal_leads")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("company", .string)
            .field("project_type", .string, .required)
            .field("budget", .string)
            .field("timeline", .string)
            .field("details", .string, .required)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("proposal_leads").delete()
    }
}
