import Fluent
import Vapor

final class ClientUser: Model, Authenticatable, SessionAuthenticatable, @unchecked Sendable {
    static let schema = "client_users"

    typealias SessionID = UUID
    var sessionID: UUID { self.id! }

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @Field(key: "password_hash")
    var passwordHash: String

    @Field(key: "project_status")
    var projectStatus: String

    init() {}

    init(id: UUID? = nil, name: String, email: String, passwordHash: String, projectStatus: String)
    {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.projectStatus = projectStatus
    }
}
