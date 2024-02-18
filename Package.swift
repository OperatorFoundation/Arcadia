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
        .package(url: "https://github.com/OperatorFoundation/Abacus", from: "1.0.3"),
        .package(url: "https://github.com/OperatorFoundation/Bits", from: "2.0.4"),
        .package(url: "https://github.com/OperatorFoundation/Datable", from: "4.0.1"),
        .package(url: "https://github.com/OperatorFoundation/Keychain", from: "1.0.2"),
        .package(url: "https://github.com/OperatorFoundation/Nametag", from: "0.1.2"),
        .package(url: "https://github.com/OperatorFoundation/Swift-BigInt", from: "1.0.0"),
        .package(url: "https://github.com/OperatorFoundation/Transmission", from: "1.2.11"),
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
