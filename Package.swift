// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "PersonalWebsite",
            targets: ["PersonalWebsite"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
        .package(url: "https://github.com/dvrzan/ReadingTimePublishPlugin", branch: "bugfix/update_macos_version")
    ],
    targets: [
        .executableTarget(
            name: "PersonalWebsite",
            dependencies: [
              "Publish",
              "SplashPublishPlugin",
              "ReadingTimePublishPlugin"
            ]
        )
    ]
)
