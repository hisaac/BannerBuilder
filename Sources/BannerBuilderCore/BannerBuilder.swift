// Created by Isaac Halvorson on 11/14/18

import Files
import Foundation
import ShellOut

public final class BannerBuilder {

	private let arguments: [String]

	public init(arguments: [String] = CommandLine.arguments) {
		self.arguments = arguments
	}

	public func run() throws {
		let command = MagickCommand(
			bannerText: "BETA",
			inputPath: "/Users/hisaac/code/mine/BannerBuilder/Assets/app-icon/",
			outputPath: "/Users/hisaac/code/mine/BannerBuilder/Assets/output/",
			rotated: true,
			bannerColor: .orange
		)

		do {
			try command.convertImages()
		} catch {
			print(error.localizedDescription)
		}
	}

}
