// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "DeclarativeUI",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "DeclarativeUI",
            targets: ["DeclarativeUI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DeclarativeUI",
            path: "DeclarativeUI"),
        .testTarget(
            name: "DecarativeUITests",
            dependencies: ["DeclarativeUI"],
            path: "DeclarativeUITests"),
    ]
)
