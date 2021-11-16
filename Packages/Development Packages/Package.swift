// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Development Packages",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "Application",
            targets: ["Application"]
        ),
        .library(
            name: "Infrastructure",
            targets: ["Infrastructure"]
        ),
        .library(
            name: "Network",
            targets: ["Network"]
        ),
        .library(
            name: "AppleMusic",
            targets: ["AppleMusic"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: []
        ),
        .target(
            name: "Application",
            dependencies: [
                "Core"
            ]
        ),
        .target(
            name: "Infrastructure",
            dependencies: [
                "Core",
                "Application",
                "Network",
                "Swinject"
            ]
        ),
        .target(
            name: "Network",
            dependencies: []
        ),
        .target(
            name: "AppleMusic",
            dependencies: [
                "Infrastructure",
                "Application",
                "Swinject"
            ]
        ),
    ]
)
