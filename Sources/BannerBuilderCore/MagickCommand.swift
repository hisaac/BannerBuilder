// Created by Isaac Halvorson on 11/14/18

import Basic
import Foundation

struct MagickCommand {

	let bannerText: String
	let inputPath: AbsolutePath
	let inputImages: [AbsolutePath]
	let outputPath: AbsolutePath
	let rotated: Bool

	var textColor: Color
	var bannerColor: Color

	var gravity: String {
		if rotated {
			return "SouthWest"
		} else {
			return "South"
		}
	}

	var horizontalPosition: String {
		if bannerText.count == 3 {
			return "7.5"
		} else {
			return "5"
		}
	}

	init(bannerText: String,
		 inputPath: AbsolutePath,
		 outputPath: AbsolutePath,
		 rotated: Bool = false,
		 textColor: Color = .white,
		 bannerColor: Color = .red) {

		self.bannerText = bannerText
		self.inputPath = inputPath
		self.outputPath = outputPath
		self.rotated = rotated
		self.textColor = textColor
		self.bannerColor = bannerColor

		do {
			let inputFiles = try localFileSystem.getDirectoryContents(inputPath)
			self.inputImages = inputFiles.compactMap {
				let relativePath = RelativePath($0)
				if relativePath.extension == "png" {
					return AbsolutePath(inputPath, relativePath)
				} else {
					return nil
				}
			}
		} catch {
			print(error.localizedDescription)
			self.inputImages = []
		}
	}

}

extension MagickCommand {

	func convertImages() {
		for image in inputImages {
			let task = Process()
			task.launchPath = "/bin/bash"
			task.arguments = ["-c", buildMagickCommand(for: image)]
			task.launch()
			task.waitUntilExit()
		}
	}

	private func buildMagickCommand(for image: AbsolutePath) -> String {

		if rotated {

			return """
				magick \
				\(image.asString) \
				-set filename:input "%t" \
				-fill "rgb(\(bannerColor.rgbString))" \
				-draw "polygon 0,%[fx:h/3] 0,%[fx:h-h/3] %[fx:w/3],%h %[fx:w-w/3],%h" \
				-fill "rgb(\(textColor.rgbString)" \
				-gravity \(gravity) \
				-pointsize "%[fx:h/5]" \
				-draw "rotate 45 font AndaleMono text %[fx:h/4],%[fx:h/\(horizontalPosition)] '\(bannerText)'" \
				\(outputPath.asString)/%[filename:input].png
				"""

		} else {

			return """
				magick \
				\(image.asString) \
				-set filename:input "%t" \
				-gravity \(gravity) \
				-fill "rgb(\(textColor.rgbString))" \
				-undercolor "rgb(\(bannerColor.rgbString))" \
				-pointsize "%[fx:h/5]" \
				-annotate +0+0 "\\        \(bannerText)        " \
				\(outputPath.asString)%[filename:input].png
				"""
		}
	}

}
