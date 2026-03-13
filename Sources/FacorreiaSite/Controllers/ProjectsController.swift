import Vapor

struct ProjectsController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        // Serve the projects page at both / and /projects
        routes.get(use: index)
        routes.get("projects", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = ProjectsContext(
            title: "Projects | FC Software Studio",
            activePage: "projects",
            trustItems: [
                TrustItem(icon: "🌍", value: "4+", label: "Countries"),
                TrustItem(icon: "🚀", value: "15+", label: "Projects Delivered"),
                TrustItem(icon: "⚡", value: "7+", label: "Years Experience"),
                TrustItem(icon: "🛡️", value: "10+", label: "Technologies"),
            ],
            projects: [
                ProjectItem(
                    title: "FanAPI",
                    description:
                        "A RESTful API for Fandemic built with Go, featuring JWT-based authentication, real-time group chat via WebSockets, profile and contacts management, and interactive OpenAPI documentation with Scalar.",
                    tags: ["Go", "REST API", "WebSocket", "JWT", "PostgreSQL"],
                    category: "Backend API",
                    githubLink: "Private",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: true,
                    icon: "⚙️",
                    iconUrl:
                        "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original.svg"
                ),
                ProjectItem(
                    title: "Pamozi CRM",
                    description:
                        "Pamozi provides dedicated used glasses for communities in need and that cannot afford them. To help with logistics, a Platform was built so they can manage data, users and stock management.",
                    tags: ["Go", "Server Side Rendering", "Templ", "HTMX", "PostgreSQL"],
                    category: "Backend API",
                    githubLink: "https://github.com/FACorreiaa/glasses-management-platform",
                    liveLink: "https://pamozi.de",
                    hasLiveLink: true ,
                    featured: true,
                    icon: "⚙️",
                    iconUrl:
                        "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original.svg"
                ),
                ProjectItem(
                    title: "iOS E-Commerce App",
                    description:
                        "A native iOS e-commerce application built with Swift and SwiftUI, featuring Apple Pay integration and smooth animations.",
                    tags: ["Swift", "SwiftUI", "CoreData", "Combine"],
                    category: "iOS App",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: true,
                    icon: "📱",
                    iconUrl:
                        "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/apple/apple-original.svg"
                ),
                ProjectItem(
                    title: "Android Fitness Tracker",
                    description:
                        "Native Android application for tracking daily workouts, integrations with health APIs, built purely with Kotlin and Jetpack Compose.",
                    tags: ["Kotlin", "Jetpack Compose", "Android SDK"],
                    category: "Android App",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: true,
                    icon: "🤖",
                    iconUrl:
                        "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/android/android-original.svg"
                ),
                ProjectItem(
                    title: "Web Dashboard MVP",
                    description:
                        "Responsive, high-performance web dashboard with real-time analytics tailored for enterprise business needs.",
                    tags: ["React", "TypeScript", "Tailwind CSS"],
                    category: "Web App",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "https://facorreia.com",
                    hasLiveLink: true,
                    featured: true,
                    icon: "💻",
                    iconUrl:
                        "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg"
                ),
                ProjectItem(
                    title: "Financial Services Platform",
                    description:
                        "Modular web services for finance sector with Go, Postgres, MSSQL, and GraphQL. Built scalable APIs for financial data processing.",
                    tags: ["Go", "GraphQL", "Postgres", "MSSQL"],
                    category: "Backend",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: false,
                    icon: "⚙️",
                    iconUrl: nil
                ),
                ProjectItem(
                    title: "Network Tracking App",
                    description:
                        "Web version of mobile network tracking application using React and Rust with real-time telemetry integration.",
                    tags: ["React", "Rust", "gRPC", "OTLP"],
                    category: "Full Stack",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: false,
                    icon: "📡",
                    iconUrl: nil
                ),
                ProjectItem(
                    title: "Social Learning Platform",
                    description:
                        "Cross-platform mobile and web app with React Native and TypeScript. Full backoffice configuration capabilities.",
                    tags: ["React Native", "TypeScript", "Go"],
                    category: "Mobile",
                    githubLink: "https://github.com/FACorreiaa",
                    liveLink: "",
                    hasLiveLink: false,
                    featured: false,
                    icon: "📱",
                    iconUrl: nil
                ),
            ]
        )

        return try await req.view.render("projects", context)
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
    let title: String
    let description: String
    let tags: [String]
    let category: String
    let githubLink: String
    let liveLink: String
    let hasLiveLink: Bool  // Used for `#if(hasLiveLink)` in Leaf
    let featured: Bool
    let icon: String  // Fallback emoji icon
    let iconUrl: String?  // Devicon SVG url
}
