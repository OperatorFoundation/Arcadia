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
        .package(url: "https://github.com/OperatorFoundation/Abacus", branch: "release"),
        .package(url: "https://github.com/OperatorFoundation/Bits", branch: "release"),
        .package(url: "https://github.com/OperatorFoundation/Datable", branch: "4.0.0"),
        .package(url: "https://github.com/OperatorFoundation/Keychain", branch: "release"),
        .package(url: "https://github.com/OperatorFoundation/Nametag", branch: "0.1.1"),
        .package(url: "https://github.com/OperatorFoundation/Swift-BigInt", branch: "release"),
        .package(url: "https://github.com/OperatorFoundation/Transmission", branch: "release"),
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
