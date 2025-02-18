// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MailComposer",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macCatalyst(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "MailComposer",
            targets: ["MailComposer"]
        )
    ],
    targets: [
        .target(name: "MailComposer")
    ]
)
