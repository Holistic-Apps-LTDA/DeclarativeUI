//import PackageDescription
//let package = Package(
//    name: "DeclarativeUI",
//    products: [
//        // Products define the executables and libraries produced by a package, and make them visible to other packages.
//        .library(
//            name: "DeclarativeUI",
//            targets: ["DeclarativeUI"]),
//    ],
//    dependencies: [
//        .package(
//              url: "https://github.com/apple/swift-collections.git",
//              .upToNextMajor(from: "1.0.0")
//            )
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
//        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
//        .target(
//            name: "DeclarativeUI",
//            dependencies: [
//                .product(name: "Collections", package: "swift-collections")
//            ]),
//        .testTarget(
//            name: "DeclarativeUITests",
//            dependencies: ["DeclarativeUI"]),
//    ]
//)
