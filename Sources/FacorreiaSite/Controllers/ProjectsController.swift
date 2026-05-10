import Vapor

struct ProjectsController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get(use: index)
        routes.get("projects", use: index)
        routes.get("projects", ":slug", use: detail)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = ProjectsContext(
            title: "Projects | FC Software Studio",
            activePage: "projects",
            trustItems: Self.trustItems,
            projects: Self.allProjects
        )
        return try await req.view.render("projects", context)
    }

    @Sendable
    func detail(req: Request) async throws -> View {
        guard let slug = req.parameters.get("slug"),
              let project = Self.allProjects.first(where: { $0.slug == slug })
        else {
            throw Abort(.notFound)
        }

        let detailContext = Self.detailContext(for: project)
        return try await req.view.render("project-detail", detailContext)
    }

    // MARK: - Static data

    static let trustItems: [TrustItem] = [
        TrustItem(icon: "🌍", value: "4+", label: "Countries"),
        TrustItem(icon: "🚀", value: "15+", label: "Projects Delivered"),
        TrustItem(icon: "⚡", value: "7+", label: "Years Experience"),
        TrustItem(icon: "🛡️", value: "10+", label: "Technologies"),
    ]

    static let allProjects: [ProjectItem] = [
        ProjectItem(
            slug: "norviq",
            title: "Norviq",
            roleTag: "Independent",
            description:
                "A focused investing workspace for portfolios, watchlists, targets, and market context. Build and maintain due diligence notes, define base/bear/bull scenarios, and follow performance across your watchlist in one place.",
            tags: ["Vapor (Swift)", "SwiftUI", "Docker", "PostgreSQL", "Redis", "Hetzner VPS"],
            category: "Full Stack / iOS App",
            githubLink: "Private",
            liveLink: "https://apps.apple.com/",
            hasLiveLink: true,
            featured: true,
            icon: "📈",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/swift/swift-original.svg",
            logoAsset: "/static/projects/norviq-icon.png"
        ),
        ProjectItem(
            slug: "luminavault",
            title: "LuminaVault",
            roleTag: "Independent",
            description:
                "Self-hosted, private, AI-powered second brain. Capture screenshots, notes, photos, locations, and HealthKit data into a Markdown vault you fully own. The Hermes-powered kb-compile engine turns raw inputs into a queryable knowledge base that learns your patterns over time.",
            tags: ["SwiftUI", "Hummingbird 2", "Hermes Agent", "PostgreSQL", "pgvector", "Docker"],
            category: "iOS App / Self-Hosted",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "🧠",
            iconUrl: nil,
            logoAsset: "/static/projects/luminavault-icon.jpg"
        ),
        ProjectItem(
            slug: "hermes",
            title: "Hermes",
            roleTag: "Independent",
            description:
                "A private gateway and automation hub hosted on a VPS. Hermes acts as a central coordinator for multiple platforms, enabling seamless communication between various AI models, webhooks, and personal services while maintaining strict privacy and data sovereignty.",
            tags: ["Docker", "VPS", "Gateway", "Swift", "API"],
            category: "Backend API",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "🤖",
            iconUrl: nil,
            logoAsset: nil
        ),
        ProjectItem(
            slug: "hermesvault-backend",
            title: "HermesVault Backend",
            roleTag: "Independent",
            description:
                "The secure, self-hosted backend for HermesVault — your private Obsidian + AI second brain. Built with Hummingbird 2, it features a robust 'kb-compile' engine that transforms raw Markdown inputs into a structured, queryable knowledge base with semantic search powered by pgvector.",
            tags: ["Swift 6", "Hummingbird 2", "Postgres", "pgvector", "Docker"],
            category: "Backend API",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "⚙️",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/swift/swift-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "hermesvault-client",
            title: "HermesVault Client",
            roleTag: "Independent",
            description:
                "A native iOS application providing a first-class mobile experience for your self-hosted memory layer. Featuring deep system integration, Vision-based OCR for screenshots, and native capture of photos, notes, and HealthKit data, it brings your second brain to your pocket with native polish.",
            tags: ["SwiftUI", "SwiftData", "Vision OCR", "AVFoundation"],
            category: "iOS App",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "📱",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/apple/apple-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "hermes-integrations",
            title: "Hermes Integrations",
            roleTag: "Independent",
            description:
                "A suite of messaging integrations for the Hermes gateway. These services enable real-time interaction with your private AI assistant via Discord, Slack, and Telegram, allowing for remote command execution, status updates, and instant knowledge capture from your most-used communication platforms.",
            tags: ["Swift", "Discord API", "Slack API", "Telegram Bot API", "Webhooks"],
            category: "Integrations / Services",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "🔌",
            iconUrl: nil,
            logoAsset: nil
        ),
        ProjectItem(
            slug: "fanapi",
            title: "FanAPI",
            roleTag: "Client Work",
            description:
                "A RESTful API for Fandemic built with Go, featuring JWT-based authentication, real-time group chat via WebSockets, profile and contacts management, and interactive OpenAPI documentation with Scalar.",
            tags: ["Go", "REST API", "WebSocket", "JWT", "PostgreSQL"],
            category: "Backend API",
            githubLink: "Private",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "⚙️",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "pamozi-crm",
            title: "Pamozi CRM",
            roleTag: "Client Work",
            description:
                "Pamozi provides dedicated used glasses for communities in need and that cannot afford them. To help with logistics, a Platform was built so they can manage data, users and stock management.",
            tags: ["Go", "Server Side Rendering", "Templ", "HTMX", "PostgreSQL"],
            category: "Backend API",
            githubLink: "https://github.com/FACorreiaa/glasses-management-platform",
            liveLink: "https://pamozi.de",
            hasLiveLink: true,
            featured: true,
            icon: "⚙️",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "ios-ecommerce",
            title: "iOS E-Commerce App",
            roleTag: "Client Work",
            description:
                "A native iOS e-commerce application built with Swift and SwiftUI, featuring Apple Pay integration and smooth animations.",
            tags: ["Swift", "SwiftUI", "CoreData", "Combine"],
            category: "iOS App",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "📱",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/apple/apple-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "android-fitness-tracker",
            title: "Android Fitness Tracker",
            roleTag: "Client Work",
            description:
                "Native Android application for tracking daily workouts, integrations with health APIs, built purely with Kotlin and Jetpack Compose.",
            tags: ["Kotlin", "Jetpack Compose", "Android SDK"],
            category: "Android App",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "",
            hasLiveLink: false,
            featured: true,
            icon: "🤖",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/android/android-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "web-dashboard-mvp",
            title: "Web Dashboard MVP",
            roleTag: "Client Work",
            description:
                "Responsive, high-performance web dashboard with real-time analytics tailored for enterprise business needs.",
            tags: ["React", "TypeScript", "Tailwind CSS"],
            category: "Web App",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "https://facorreia.com",
            hasLiveLink: true,
            featured: true,
            icon: "💻",
            iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg",
            logoAsset: nil
        ),
        ProjectItem(
            slug: "financial-services-platform",
            title: "Financial Services Platform",
            roleTag: "Client Work",
            description:
                "Modular web services for finance sector with Go, Postgres, MSSQL, and GraphQL. Built scalable APIs for financial data processing.",
            tags: ["Go", "GraphQL", "Postgres", "MSSQL"],
            category: "Backend",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "",
            hasLiveLink: false,
            featured: false,
            icon: "⚙️",
            iconUrl: nil,
            logoAsset: nil
        ),
        ProjectItem(
            slug: "network-tracking-app",
            title: "Network Tracking App",
            roleTag: "Client Work",
            description:
                "Web version of mobile network tracking application using React and Rust with real-time telemetry integration.",
            tags: ["React", "Rust", "gRPC", "OTLP"],
            category: "Full Stack",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "",
            hasLiveLink: false,
            featured: false,
            icon: "📡",
            iconUrl: nil,
            logoAsset: nil
        ),
        ProjectItem(
            slug: "social-learning-platform",
            title: "Social Learning Platform",
            roleTag: "Client Work",
            description:
                "Cross-platform mobile and web app with React Native and TypeScript. Full backoffice configuration capabilities.",
            tags: ["React Native", "TypeScript", "Go"],
            category: "Mobile",
            githubLink: "https://github.com/FACorreiaa",
            liveLink: "",
            hasLiveLink: false,
            featured: false,
            icon: "📱",
            iconUrl: nil,
            logoAsset: nil
        ),
    ]

    // MARK: - Detail context builder

    static func detailContext(for project: ProjectItem) -> ProjectDetailContext {
        switch project.slug {
        case "norviq":
            return ProjectDetailContext(
                title: "\(project.title) | FC Software Studio",
                activePage: "projects",
                project: project,
                tagline: "A focused investing workspace for portfolios, watchlists, targets, and market context.",
                longDescription: [
                    "Norviq is a personal investing workspace for active investors who want their research, holdings, and decisions in one calm, fast app. Track portfolio performance with cost-basis accuracy, capture due-diligence notes alongside watchlists, and define base / bear / bull scenarios for the names you care about.",
                    "The iOS client is built natively in SwiftUI with Swift Charts, secured by MFA, Face ID, and an app-lock layer. It talks to a Vapor-powered backend hosted on a budget Hetzner VPS using Postgres and Redis, with broker import options (CSV today, native API integrations soon).",
                ],
                features: [
                    DetailFeature(title: "Portfolio clarity", body: "Track holdings, cost basis, and allocation in real time with cost-basis donut charts."),
                    DetailFeature(title: "Research workspace", body: "Watchlists, stock insights, valuation editor, projections, and notes — close to every decision."),
                    DetailFeature(title: "Earnings & news", body: "Built-in earnings calendar and market news feed so context is one tap away."),
                    DetailFeature(title: "Budget & expenses", body: "A side workspace for budget planning, expense comparison, and reporting (Pro)."),
                    DetailFeature(title: "Security first", body: "MFA, Face ID, app-lock with security code, encrypted token storage."),
                    DetailFeature(title: "Native polish", body: "Pure SwiftUI on iOS 16+, Swift Charts visuals, RevenueCat-powered Pro tier."),
                ],
                techStack: ["SwiftUI", "Swift Charts", "Vapor", "PostgreSQL", "Redis", "Docker", "RevenueCat", "Factory DI", "PostHog", "Sentry"],
                socialLinks: [
                    DetailLink(label: "Instagram", url: "https://instagram.com/norviqplan"),
                    DetailLink(label: "X (Twitter)", url: "https://x.com/NorviqPlanner"),
                    DetailLink(label: "Discord", url: "https://discord.gg/3QVkas3rH"),
                ],
                hasFeatures: true,
                hasTechStack: true,
                hasSocialLinks: true,
                appStoreUrl: nil,           // TODO: paste App Store URL here when ready
                hasAppStoreUrl: false,
                playStoreUrl: nil,
                hasPlayStoreUrl: false,
                backendNote: "Powered by api.norviqa.io",
                bannerAsset: nil,
                hasBanner: false
            )

        case "luminavault":
            return ProjectDetailContext(
                title: "\(project.title) | FC Software Studio",
                activePage: "projects",
                project: project,
                tagline: "Your second brain, self-hosted. Private, AI-powered memory layer you actually own.",
                longDescription: [
                    "LuminaVault is a self-improving memory layer for researchers, analysts, and anyone who wants a living second brain that they truly own. Capture screenshots, photos, Apple Maps locations, HealthKit data, Safari links, and notes — all saved as clean Markdown in your private vault, never leaving your VPS or device.",
                    "Meet Lumina, your personal knowledge guardian. One tap with `kb-compile` turns raw inputs into a smart, searchable wiki. Lumina learns your habits, answers questions about your past with perfect context, drafts memos, and surfaces only the patterns that matter.",
                    "Built native-first on iOS with a Hummingbird 2 + Postgres + pgvector backend you self-host via Docker. Privacy-first AI: bring your own LLM key, your memory layer stays on your infrastructure.",
                ],
                features: [
                    DetailFeature(title: "Effortless capture", body: "Screenshots, photos, Apple Maps locations, HealthKit data, Safari links, voice notes — all saved as clean Markdown."),
                    DetailFeature(title: "kb-compile engine", body: "One tap turns raw notes into a structured, queryable knowledge base with pgvector semantic search."),
                    DetailFeature(title: "Learns your patterns", body: "Lumina builds a model of how you think, work, and live, then surfaces context when it matters."),
                    DetailFeature(title: "Answer your past", body: "Ask any question about your captured history and get grounded answers with citations."),
                    DetailFeature(title: "Quiet, smart nudges", body: "Notifications only when something actually matters — sleep trends, opportunities, anomalies."),
                    DetailFeature(title: "100% yours", body: "Self-hosted via Docker. Per-tenant vault filesystem, JWT auth, BYO LLM key. Data never leaves your infrastructure."),
                ],
                techStack: ["SwiftUI", "SwiftData", "Vision OCR", "AVFoundation", "Swift 6", "Hummingbird 2", "PostgreSQL", "pgvector", "Hermes Agent", "Docker"],
                socialLinks: [],
                hasFeatures: true,
                hasTechStack: true,
                hasSocialLinks: false,
                appStoreUrl: nil,           // TODO: paste App Store URL here when ready
                hasAppStoreUrl: false,
                playStoreUrl: nil,          // TODO: paste Play Store URL here when ready
                hasPlayStoreUrl: false,
                backendNote: "Self-hosted on your own VPS — your second brain belongs to you.",
                bannerAsset: "/static/projects/luminavault-banner.jpg",
                hasBanner: true
            )

        default:
            return ProjectDetailContext(
                title: "\(project.title) | FC Software Studio",
                activePage: "projects",
                project: project,
                tagline: project.category,
                longDescription: [project.description],
                features: [],
                techStack: project.tags,
                socialLinks: [],
                hasFeatures: false,
                hasTechStack: !project.tags.isEmpty,
                hasSocialLinks: false,
                appStoreUrl: nil,
                hasAppStoreUrl: false,
                playStoreUrl: nil,
                hasPlayStoreUrl: false,
                backendNote: nil,
                bannerAsset: nil,
                hasBanner: false
            )
        }
    }
}

// MARK: - View Models

struct ProjectsContext: Content {
    let title: String
    let activePage: String
    let trustItems: [TrustItem]
    let projects: [ProjectItem]
}

struct TrustItem: Content {
    let icon: String
    let value: String
    let label: String
}

struct ProjectItem: Content {
    let slug: String
    let title: String
    let roleTag: String
    let description: String
    let tags: [String]
    let category: String
    let githubLink: String
    let liveLink: String
    let hasLiveLink: Bool
    let featured: Bool
    let icon: String
    let iconUrl: String?
    let logoAsset: String?
}

struct DetailFeature: Content {
    let title: String
    let body: String
}

struct DetailLink: Content {
    let label: String
    let url: String
}

struct ProjectDetailContext: Content {
    let title: String
    let activePage: String
    let project: ProjectItem
    let tagline: String
    let longDescription: [String]
    let features: [DetailFeature]
    let techStack: [String]
    let socialLinks: [DetailLink]
    let hasFeatures: Bool
    let hasTechStack: Bool
    let hasSocialLinks: Bool
    let appStoreUrl: String?
    let hasAppStoreUrl: Bool
    let playStoreUrl: String?
    let hasPlayStoreUrl: Bool
    let backendNote: String?
    let bannerAsset: String?
    let hasBanner: Bool
}
