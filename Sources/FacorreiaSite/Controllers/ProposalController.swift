import Fluent
import Vapor

struct ProposalController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let proposals = routes.grouped("proposal")
        proposals.get(use: index)
        proposals.post(use: submit)
    }

    /// Renders the initial empty proposal form
    @Sendable
    func index(req: Request) async throws -> View {
        let context = ProposalContext(
            title: "Request Proposal | FC Software Studio",
            activePage: "proposal",
            success: false,
            error: nil,
            form: ProposalFormData(
                name: "",
                email: "",
                company: "",
                projectType: "",
                budget: "",
                timeline: "",
                details: ""
            )
        )
        return try await req.view.render("proposal", context)
    }

    /// Handles form submission
    @Sendable
    func submit(req: Request) async throws -> View {
        let input = try req.content.decode(ProposalFormData.self)

        // Anti-spam honey pot check
        if let website = try? req.content.decode(Honeypot.self).website, !website.isEmpty {
            // Fake success for bots
            return try await renderSuccess(req: req)
        }

        // Basic validation
        if input.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || input.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || input.projectType.isEmpty
            || input.details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {

            let context = ProposalContext(
                title: "Request Proposal | FC Software Studio",
                activePage: "proposal",
                success: false,
                error: "Please fill out all required fields.",
                form: input
            )
            return try await req.view.render("proposal", context)
        }

        // Validate Email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if input.email.range(of: emailRegex, options: .regularExpression) == nil {
            let context = ProposalContext(
                title: "Request Proposal | FC Software Studio",
                activePage: "proposal",
                success: false,
                error: "Please enter a valid email address.",
                form: input
            )
            return try await req.view.render("proposal", context)
        }

        // Save the valid proposal to the SQLite database
        let lead = ProposalLead(
            name: input.name,
            email: input.email,
            company: input.company,
            projectType: input.projectType,
            budget: input.budget,
            timeline: input.timeline,
            details: input.details
        )
        try await lead.save(on: req.db)

        // Phase 2: Alert Admin dynamically via Discord
        NotificationService.sendLeadNotification(app: req.application, lead: lead)

        req.logger.info(
            "New proposal request from \(input.name) (\(input.email)) for \(input.projectType) saved to database"
        )

        return try await renderSuccess(req: req)
    }

    // MARK: - Helpers

    private func renderSuccess(req: Request) async throws -> View {
        let context = ProposalContext(
            title: "Request Proposal | FC Software Studio",
            activePage: "proposal",
            success: true,
            error: nil,
            form: ProposalFormData(
                name: "",
                email: "",
                company: "",
                projectType: "",
                budget: "",
                timeline: "",
                details: ""
            )
        )
        return try await req.view.render("proposal", context)
    }
}

// MARK: - View Models

struct ProposalContext: Content {
    let title: String
    let activePage: String
    let success: Bool
    let error: String?
    let form: ProposalFormData
}

struct ProposalFormData: Content {
    let name: String
    let email: String
    let company: String?
    let projectType: String
    let budget: String?
    let timeline: String?
    let details: String
}

struct Honeypot: Content {
    let website: String?
}
