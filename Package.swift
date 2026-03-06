// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "FacorreiaSite",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "4.3.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // 🗄 An ORM for Swift.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.12.0"),
        // 🪶 SQLite driver for Fluent.
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.8.0"),
        // 🖋 Fast and flexible Markdown parser built in Swift.
        .package(url: "https://github.com/JohnSundell/Ink.git", from: "0.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "FacorreiaSite",
            dependencies: [
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Ink", package: "Ink"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "FacorreiaSiteTests",
            dependencies: [
                .target(name: "FacorreiaSite"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny")
    ]
}
