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
			bannerText: "DEV",
			inputPath: "/Users/hisaac/code/mine/BannerBuilder/input/app-icon-1024@1x.png",
			outputPath: "/Users/hisaac/code/mine/BannerBuilder/%[filename:input]-dev.png"
		)

		do {
			let output = try shellOut(to: command.string)
			print(output)
		} catch {
			let error = error as! ShellOutError
			print(error.message) // STDERR
			print(error.output)  // STDOUT
		}
	}

}

public extension BannerBuilder {

	enum Error: Swift.Error {
		case failedToCreateFile
	}

}
