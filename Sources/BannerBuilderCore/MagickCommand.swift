// Created by Isaac Halvorson on 11/14/18

import Files
import ShellOut

struct MagickCommand {

	let bannerText: String
	let inputPath: String
	let inputImagePaths: [String]
	let outputPath: String
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
		 inputPath: String,
		 outputPath: String,
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
			let inputImages = try Folder(path: inputPath).files
			self.inputImagePaths = inputImages.compactMap {
				if $0.extension == "png" {
					return $0.name
				} else {
					return nil
				}
			}
		} catch {
			print(error.localizedDescription)
			self.inputImagePaths = []
		}
	}

}

extension MagickCommand {

	func convertImages() throws {

		for image in inputImagePaths {

			var commandString = String()

			if rotated {

				commandString = """
					magick \
						\(inputPath + image) \
						-set filename:input "%t" \
						-fill "rgb(\(bannerColor.rgbString))" \
						-draw "polygon 0,%[fx:h/3] 0,%[fx:h-h/3] %[fx:w/3],%h %[fx:w-w/3],%h" \
						-fill "rgb(\(textColor.rgbString)" \
						-gravity \(gravity) \
						-pointsize "%[fx:h/5]" \
						-draw "rotate 45 font AndaleMono text %[fx:h/4],%[fx:h/\(horizontalPosition)] '\(bannerText)'" \
						\(outputPath)%[filename:input].png
					"""

			} else {

				commandString = """
					magick \
						\(inputPath + image) \
						-set filename:input "%t" \
						-gravity \(gravity) \
						-fill "rgb(\(textColor.rgbString))" \
						-undercolor "rgb(\(bannerColor.rgbString))" \
						-pointsize "%[fx:h/5]" \
						-annotate +0+0 "\\        \(bannerText)        " \
						\(outputPath)%[filename:input].png
					"""

			}

			do {
				let output = try shellOut(to: commandString)
				print(output)
			} catch {
				let error = error as! ShellOutError
				print(error.message) // STDERR
				print(error.output)  // STDOUT
			}
		}
	}

}
