// Created by Isaac Halvorson on 11/14/18

import Basic
import Utility

public final class BannerBuilder {

	private let arguments: [String]
	private let parser: ArgumentParser

	public init(arguments: [String] = CommandLine.arguments) {
		self.arguments = arguments

		parser = ArgumentParser(
			commandName: "bannerbuilder",
			usage: "--input \"path/to/input\" --output \"path/to/output\" --bannerText \"DEV\" --bannerColor \"red\"",
			overview: "BannerBuilder will automatically add a banner to your App's icon"
		)
	}

	public func run() throws {

		let input = parser.add(
			option: "--input",
			shortName: "-i",
			kind: PathArgument.self,
			usage: "The file path containing the images you would like to add a banner to",
			completion: .filename
		)

		let output = parser.add(
			option: "--output",
			shortName: "-o",
			kind: PathArgument.self,
			usage: "The file path to where you'd like the newly created images to end up",
			completion: .filename
		)

		let bannerTextValue = parser.add(
			option: "--bannerText",
			shortName: "-t",
			kind: String.self,
			usage: "The text you'd like to have displayed on the banner (Note: Currently only 3 or 4 character strings are supported)",
			completion: .none
		)

		let allColors: [(value: String, description: String)] = Color.allCases.map {
			return (value: $0.rgbString, description: $0.rawValue)
		}

		let bannerColorValue = parser.add(
			option: "--bannerColor",
			shortName: "-c",
			kind: String.self,
			usage: "The color of the banner. Can provide a color defined in the HIG, or RGB values in rrr,ggg,bbb format (e.g. 255,23,87)",
			completion: .values(allColors)
		)

		do {
			// The first argument is the path to the BannerBuilder executable, so we ignore that here
			let args = Array(arguments.dropFirst())
			let result = try parser.parse(args)

			// Print the usage description if the user didn't provide any arguments
			guard args.count > 0 else {
				parser.printUsage(on: stdoutStream)
				return
			}

			guard let bannerText = result.get(bannerTextValue) else { throw Error.missingBannerText }
			guard let bannerColor = result.get(bannerColorValue) else { throw Error.missingBannerColor }
			guard let inputPath = result.get(input) else { throw Error.missingInputPath }
			guard let outputPath = result.get(output) else { throw Error.missingOutputPath }

			let command = MagickCommand(
				bannerText: bannerText,
				inputPath: inputPath.path,
				outputPath: outputPath.path,
				rotated: true,
				textColor: .white,
				bannerColor: Color(rawValue: bannerColor)
			)

			try command.convertImages()

		} catch let error as ArgumentParserError {
			print(error.description)
		} catch {
			print(error.localizedDescription)
		}
	}

}

public extension BannerBuilder {
	enum Error: Swift.Error {
		case missingBannerText
		case missingBannerColor
		case missingInputPath
		case missingOutputPath
	}
}
