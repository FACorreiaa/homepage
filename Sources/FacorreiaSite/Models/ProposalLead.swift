import Fluent
import Vapor

final class ProposalLead: Model, @unchecked Sendable {
    static let schema = "proposal_leads"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @OptionalField(key: "company")
    var company: String?

    @Field(key: "project_type")
    var projectType: String

    @OptionalField(key: "budget")
    var budget: String?

    @OptionalField(key: "timeline")
    var timeline: String?

    @Field(key: "details")
    var details: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {}

    init(
        id: UUID? = nil, name: String, email: String, company: String? = nil, projectType: String,
        budget: String? = nil, timeline: String? = nil, details: String
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.company = company
        self.projectType = projectType
        self.budget = budget
        self.timeline = timeline
        self.details = details
    }
}
