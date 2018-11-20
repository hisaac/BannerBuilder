// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "BannerBuilder",
	dependencies: [
		.package(url: "https://github.com/apple/swift-package-manager.git", from: "0.3.0"),
		.package(url: "https://github.com/JohnSundell/Files", from: "2.0.0"),
		.package(url: "https://github.com/JohnSundell/ShellOut", from: "2.0.0")
	],
	targets: [
		.target(
			name: "BannerBuilder",
			dependencies: ["BannerBuilderCore"]
		),
		.target(
			name: "BannerBuilderCore",
			dependencies: ["Files", "ShellOut", "Utility"]
		),
		.testTarget(
			name: "BannerBuilderTests",
			dependencies: ["BannerBuilder", "Files", "ShellOut"]
		),
	]
)
