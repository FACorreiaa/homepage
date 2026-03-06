import Vapor

struct AboutController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("about", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = AboutContext(
            title: "About | FC Software Studio",
            activePage: "about",
            stats: [
                Stat(value: "7+", label: "Years Experience", delay: "100"),
                Stat(value: "15+", label: "Projects Delivered", delay: "200"),
                Stat(value: "10+", label: "Technologies", delay: "300"),
                Stat(value: "4", label: "Countries", delay: "400"),
            ],
            values: [
                ValueCard(
                    emoji: "🤝",
                    title: "Team Player",
                    description: "Collaborative approach to solving complex problems together",
                    gradientClasses: "from-indigo-500/10 to-blue-500/10"
                ),
                ValueCard(
                    emoji: "🧩",
                    title: "Problem Solving",
                    description: "Breaking down challenges into elegant, maintainable solutions",
                    gradientClasses: "from-cyan-500/10 to-teal-500/10"
                ),
                ValueCard(
                    emoji: "💡",
                    title: "Innovation",
                    description: "Staying ahead with modern patterns and emerging technologies",
                    gradientClasses: "from-amber-500/10 to-orange-500/10"
                ),
                ValueCard(
                    emoji: "🎯",
                    title: "Delivery",
                    description: "Focused on shipping quality software that makes an impact",
                    gradientClasses: "from-emerald-500/10 to-green-500/10"
                ),
            ],
            interests: [
                "🚀 Technology",
                "🌍 Open Source",
                "💻 Innovation",
                "📚 Continuous Learning",
                "🏃 Fitness",
            ],
            contacts: [
                ContactCard(
                    emoji: "📞", label: "Phone", value: "+351 937042328", href: "tel:+351937042328"),
                ContactCard(
                    emoji: "✉️", label: "Email", value: "fernandocorreia316@gmail.com",
                    href: "mailto:fernandocorreia316@gmail.com"),
                ContactCard(
                    emoji: "🔗", label: "GitHub", value: "github.com/FACorreiaa",
                    href: "https://github.com/FACorreiaa"),
            ]
        )

        return try await req.view.render("about", context)
    }
}

// MARK: - View Models

struct AboutContext: Content {
    let title: String
    let activePage: String
    let stats: [Stat]
    let values: [ValueCard]
    let interests: [String]
    let contacts: [ContactCard]
}

struct Stat: Content {
    let value: String
    let label: String
    let delay: String
}

struct ValueCard: Content {
    let emoji: String
    let title: String
    let description: String
    let gradientClasses: String
}

struct ContactCard: Content {
    let emoji: String
    let label: String
    let value: String
    let href: String
}
