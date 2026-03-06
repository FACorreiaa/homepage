import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: ProjectsController())
    try app.register(collection: AboutController())
    try app.register(collection: CurriculumController())
    try app.register(collection: StackController())
    try app.register(collection: BlogController())
    try app.register(collection: PlayController())
    try app.register(collection: ProposalController())
    try app.register(collection: AdminController())

    app.get("book-call") { req -> Response in
        let defaultCalendlyURL = "https://calendly.com/fernandocorreia316"
        let configuredCalendlyURL =
            Environment.get("CALENDLY_URL")?.trimmingCharacters(in: .whitespacesAndNewlines)
        let calendlyURL = normalizeCalendlyURL(configuredCalendlyURL, fallback: defaultCalendlyURL)

        return req.redirect(to: calendlyURL, redirectType: .temporary)
    }
}

private func normalizeCalendlyURL(_ rawValue: String?, fallback: String) -> String {
    guard let rawValue, !rawValue.isEmpty else {
        return fallback
    }

    if rawValue.hasPrefix("http://") || rawValue.hasPrefix("https://") {
        return rawValue
    }

    if rawValue.hasPrefix("calendly.com/") {
        return "https://" + rawValue
    }

    return "https://calendly.com/"
        + rawValue.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
}
