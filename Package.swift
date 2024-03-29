// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Arcadia",
    platforms: [.macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Arcadia",
            targets: ["Arcadia"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/OperatorFoundation/Abacus", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Bits", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Datable", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Keychain", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Nametag", branch: "main"),
        .package(url: "https://github.com/blanu/Swift-BigInt", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Transmission", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Arcadia",
            dependencies: [
                "Abacus",
                "Bits",
                "Datable",
                "Keychain",
                "Nametag",
                "Transmission",

                .product(name: "BigNumber", package: "swift-BigInt"),
            ]
        ),
        .testTarget(
            name: "ArcadiaTests",
            dependencies: ["Arcadia"]),
    ],
    swiftLanguageVersions: [.v5]
)
