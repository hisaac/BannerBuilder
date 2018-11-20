// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "BannerBuilder",
	dependencies: [
		.package(url: "https://github.com/apple/swift-package-manager.git", from: "0.3.0")
	],
	targets: [
		.target(
			name: "BannerBuilder",
			dependencies: ["BannerBuilderCore"]
		),
		.target(
			name: "BannerBuilderCore",
			dependencies: ["SwiftPM"]
		),
		.testTarget(
			name: "BannerBuilderTests",
			dependencies: ["BannerBuilder", "SwiftPM"]
		),
	]
)
