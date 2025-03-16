// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BrandTheme",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BrandTheme",
            targets: ["BrandTheme"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "BrandTheme",
            dependencies: []),
    ]
) 