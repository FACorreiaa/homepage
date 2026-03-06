import Vapor

struct NotificationService {

    /// Asynchronously pings a Discord webhook with the incoming lead details,
    /// running fully detached from the main route request to prevent blocking the user's response time.
    static func sendLeadNotification(app: Application, lead: ProposalLead) {
        guard let webhookURL = Environment.get("DISCORD_WEBHOOK_URL"), !webhookURL.isEmpty else {
            app.logger.info(
                "Skipping Discord notification: DISCORD_WEBHOOK_URL not set in environment.")
            return
        }

        let content = """
            🚀 **New Project Proposal Lead!** 🚀
            **Name:** \(lead.name)
            **Email:** \(lead.email)
            **Company:** \(lead.company ?? "N/A")
            **Project Type:** \(lead.projectType)
            **Budget:** \(lead.budget ?? "N/A")
            **Timeline:** \(lead.timeline ?? "N/A")

            **Details:**
            \(lead.details)
            """

        let payload = ["content": content]

        // Spawn a background task using the application client directly (safe outside of Request scope)
        Task {
            do {
                let response = try await app.client.post(URI(string: webhookURL)) { postReq in
                    try postReq.content.encode(payload, as: .json)
                }
                if response.status == .noContent || response.status == .ok {
                    app.logger.info("✅ Discord Lead Notification sent beautifully.")
                } else {
                    app.logger.warning("Discord webhook returned non-success: \(response.status)")
                }
            } catch {
                app.logger.error("❌ Failed to trigger Discord webhook: \(error)")
            }
        }
    }
}
