import Vapor

struct StackController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("stack", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = StackContext(
            title: "Stack | FC Software Studio",
            activePage: "stack",
            sections: [
                TechSection(
                    title: "Backend Development",
                    icon: "⚙️",
                    backgroundClass: "bg-background",
                    iconBgClass: "bg-emerald-500/15",
                    technologies: [
                        TechItem(
                            name: "Go", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original.svg"
                        ),
                        TechItem(
                            name: "C#", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/csharp/csharp-original.svg"
                        ),
                        TechItem(
                            name: "TypeScript", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/typescript/typescript-original.svg"
                        ),
                        TechItem(
                            name: "JavaScript", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/javascript/javascript-original.svg"
                        ),
                        TechItem(
                            name: "Swift", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/swift/swift-original.svg"
                        ),
                        TechItem(
                            name: "Rust", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/rust/rust-original.svg"
                        ),
                    ]
                ),
                TechSection(
                    title: "Frontend Development",
                    icon: "🎨",
                    backgroundClass: "bg-muted pattern-dots",
                    iconBgClass: "bg-blue-500/15",
                    technologies: [
                        TechItem(
                            name: "React", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg"
                        ),
                        TechItem(
                            name: "React Native", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg"
                        ),
                        TechItem(
                            name: "Angular", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/angularjs/angularjs-original.svg"
                        ),
                        TechItem(
                            name: "HTML5", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/html5/html5-original.svg"
                        ),
                        TechItem(
                            name: "CSS3", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/css3/css3-original.svg"
                        ),
                        TechItem(
                            name: "Tailwind CSS", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/tailwindcss/tailwindcss-original.svg"
                        ),
                    ]
                ),
                TechSection(
                    title: "Databases",
                    icon: "🗄️",
                    backgroundClass: "bg-background",
                    iconBgClass: "bg-purple-500/15",
                    technologies: [
                        TechItem(
                            name: "PostgreSQL", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/postgresql/postgresql-original.svg"
                        ),
                        TechItem(
                            name: "MSSQL", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/microsoftsqlserver/microsoftsqlserver-original.svg"
                        ),
                        TechItem(
                            name: "MongoDB", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/mongodb/mongodb-original.svg"
                        ),
                        TechItem(
                            name: "Redis", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/redis/redis-original.svg"
                        ),
                    ]
                ),
                TechSection(
                    title: "Cloud & APIs",
                    icon: "☁️",
                    backgroundClass: "bg-muted pattern-diagonal",
                    iconBgClass: "bg-cyan-500/15",
                    technologies: [
                        // For generic concepts, using related Devicon SVGs (network, cloud, etc) or sticking to logos of tools
                        TechItem(
                            name: "REST", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/networkx/networkx-original.svg"
                        ),  // fallback icon
                        TechItem(
                            name: "gRPC", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/grpc/grpc-original.svg"
                        ),  // fallback as plain icon is harder to find
                        TechItem(
                            name: "GraphQL", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/graphql/graphql-plain.svg"
                        ),
                        TechItem(
                            name: "Linux", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/linux/linux-original.svg"
                        ),
                        TechItem(
                            name: "Apple", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/apple/apple-original.svg"
                        ),
                    ]
                ),
                TechSection(
                    title: "DevOps & Tools",
                    icon: "🛠️",
                    backgroundClass: "bg-background",
                    iconBgClass: "bg-amber-500/15",
                    technologies: [
                        TechItem(
                            name: "Docker", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/docker/docker-original.svg"
                        ),
                        TechItem(
                            name: "Kafka", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/apachekafka/apachekafka-original.svg"
                        ),
                        TechItem(
                            name: "Git", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/git/git-original.svg"
                        ),
                        TechItem(
                            name: "GitHub", proficiency: "●●●",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/github/github-original.svg"
                        ),
                        TechItem(
                            name: "Jira", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/jira/jira-original.svg"
                        ),
                        TechItem(
                            name: "Figma", proficiency: "●●○",
                            iconUrl:
                                "https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/figma/figma-original.svg"
                        ),
                    ]
                ),
            ]
        )

        return try await req.view.render("stack", context)
    }
}

// MARK: - View Models

struct StackContext: Content {
    let title: String
    let activePage: String
    let sections: [TechSection]
}

struct TechSection: Content {
    let title: String
    let icon: String
    let backgroundClass: String
    let iconBgClass: String
    let technologies: [TechItem]
}

struct TechItem: Content {
    let name: String
    let proficiency: String
    let iconUrl: String
}
