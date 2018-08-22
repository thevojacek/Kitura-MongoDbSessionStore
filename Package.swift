// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Kitura-MongoDbSessionStore",
    products: [
        .library(
            name: "Kitura-MongoDbSessionStore",
            targets: ["Kitura-MongoDbSessionStore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OpenKitten/MongoKitten", from: "4.1.3"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Session", from: "3.2.0")
    ],
    targets: [
        .target(
            name: "Kitura-MongoDbSessionStore",
            dependencies: ["MongoKitten", "KituraSession"]),
        .testTarget(
            name: "Kitura-MongoDbSessionStoreTests",
            dependencies: ["Kitura-MongoDbSessionStore"]),
    ]
)
