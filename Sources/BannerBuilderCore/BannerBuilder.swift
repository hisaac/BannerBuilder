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

		let options = parseArguments()

		guard let bannerText = options.bannerText?.value else { throw Error.missingBannerText }
		guard let bannerColor = options.bannerColor?.value else { throw Error.missingBannerColor }
		guard let inputPath = options.inputPath?.value else { throw Error.missingInputPath }
		guard let outputPath = options.outputPath?.value else { throw Error.missingOutputPath }

		let command = MagickCommand(
			bannerText: bannerText,
			inputPath: inputPath,
			outputPath: outputPath,
			rotated: true,
			textColor: .white,
			bannerColor: Color(rawValue: bannerColor)
		)

		do {
			try command.convertImages()
		} catch {
			print(error.localizedDescription)
		}
	}

	func printUsage() {
		let executableName = (arguments[0] as NSString).lastPathComponent

		print("""
			usage:
			\(executableName) -a string1 string2
			or
			\(executableName) -p string
			or
			\(executableName) -h to show usage information
			Type \(executableName) without an option to enter interactive mode.
			"""
		)
	}

	func parseArguments() -> ArgumentValues {
		var argumentValues = ArgumentValues()

		for (index, argument) in arguments.enumerated() {
			if argument == "-t" {
				argumentValues.bannerText = .bannerText(arguments[index + 1])
			} else if argument == "-i" {
				argumentValues.inputPath = .input(arguments[index + 1])
			} else if argument == "-o" {
				argumentValues.outputPath = .output(arguments[index + 1])
			} else if argument == "-c" {
				argumentValues.bannerColor = .bannerColor(arguments[index + 1])
			}
		}

		return argumentValues
	}

}

struct ArgumentValues {
	var bannerText: Option?
	var bannerColor: Option?
	var inputPath: Option?
	var outputPath: Option?
}

public extension BannerBuilder {
	enum Error: Swift.Error {
		case missingBannerText
		case missingBannerColor
		case missingInputPath
		case missingOutputPath
	}
}

enum Option {
	case input(_ value: String)
	case output(_ value: String)
	case bannerText(_ value: String)
	case bannerColor(_ value: String)
	case unknown

	var value: String? {
		switch self {
		case let .input(value): return value
		case let .output(value): return value
		case let .bannerText(value): return value
		case let .bannerColor(value): return value
		default: return nil
		}
	}
}
