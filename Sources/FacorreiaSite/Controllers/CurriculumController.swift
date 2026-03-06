import Vapor

struct CurriculumController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("curriculum", use: index)
    }

    @Sendable
    func index(req: Request) async throws -> View {
        let context = CurriculumContext(
            title: "Curriculum | FC Software Studio",
            activePage: "curriculum",
            name: "Fernando Correia",
            role: "Software Engineer",
            phone: "+351 937042328",
            email: "fernandocorreia316@gmail.com",
            github: "https://github.com/FACorreiaa",
            experiences: [
                ExperienceItem(
                    title: "Golang Developer",
                    company: "iDWELL",
                    period: "Aug 2024 – Present",
                    location: "Vienna, Austria (Remote)",
                    bullets: [
                        "Starting financial development from ground up creating financial services to onboard clients and implementing CICD",
                        "Developing modular web services for finance sector with Go, Postgres, MSSQL, and GraphQL",
                        "Built scalable, robust APIs that streamline financial data processing",
                        "Collaborated with cross-functional teams to enhance system architecture",
                    ]
                ),
                ExperienceItem(
                    title: "Software Engineer",
                    company: "GSMK",
                    period: "Jan 2023 – Aug 2024",
                    location: "Berlin, Germany",
                    bullets: [
                        "Introduced Golang for developing CLI tools to streamline multi-technology projects",
                        "Built web version of company's mobile network tracking application using React and Rust",
                        "Developed gRPC-based microservices for efficient communication between internal services",
                        "Integrated with OTLP for real-time telemetry",
                    ]
                ),
                ExperienceItem(
                    title: "Software Engineer",
                    company: "Beedeez",
                    period: "Jan 2021 – Jan 2023",
                    location: "Paris, France",
                    bullets: [
                        "Led development of social learning platform with React Native and TypeScript",
                        "Developed Go-based tool to aggregate and manage JSON data",
                        "Built cross-platform mobile and web apps with full backoffice configuration",
                    ]
                ),
                ExperienceItem(
                    title: "Software Developer",
                    company: "Glintt HS",
                    period: "Sep 2017 – May 2019",
                    location: "Porto, Portugal",
                    bullets: [
                        "Developed web applications for healthcare sector (pharmacy and patient management)",
                        "Worked on privacy-focused blockchain project with C# and MongoDB",
                        "Created restaurant data management MVP integrated with Google My Business",
                    ]
                ),
            ],
            educations: [
                EducationItem(
                    degree: "M.S. Computer Science",
                    school: "Instituto Politécnico do Cávado e Ave (IPCA)",
                    date: "Dec 2018",
                    location: "Barcelos, Portugal",
                    gpa: "GPA: 3.7/4"
                ),
                EducationItem(
                    degree: "B.S. Computer Science",
                    school: "Instituto Politécnico do Cávado e Ave (IPCA)",
                    date: "May 2017",
                    location: "Barcelos, Portugal",
                    gpa: "GPA: 3.6/4"
                ),
            ],
            awards: [
                AwardItem(
                    icon: "🏆",
                    title: "Academic Excellence",
                    description: "Top 5% students from IPCA",
                    context: "Computer Science | 2017"
                ),
                AwardItem(
                    icon: "📜",
                    title: "Dean's List",
                    description: "Top 10% students in the program",
                    context: "IPCA | 2016"
                ),
            ],
            coursework: [
                "Distributed Systems and Microservices",
                "Cloud Computing and DevOps",
                "Database Design and Management",
                "Software Engineering Principles",
                "API Design and Development",
                "Data Structures and Algorithms",
                "Web Development Technologies",
            ]
        )

        return try await req.view.render("curriculum", context)
    }
}

// MARK: - View Models

struct CurriculumContext: Content {
    let title: String
    let activePage: String
    let name: String
    let role: String
    let phone: String
    let email: String
    let github: String
    let experiences: [ExperienceItem]
    let educations: [EducationItem]
    let awards: [AwardItem]
    let coursework: [String]
}

struct ExperienceItem: Content {
    let title: String
    let company: String
    let period: String
    let location: String
    let bullets: [String]
}

struct EducationItem: Content {
    let degree: String
    let school: String
    let date: String
    let location: String
    let gpa: String
}

struct AwardItem: Content {
    let icon: String
    let title: String
    let description: String
    let context: String
}
