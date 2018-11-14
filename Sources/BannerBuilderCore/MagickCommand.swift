// Created by Isaac Halvorson on 11/14/18

struct MagickCommand {

	let bannerText: String
	let inputPath: String
	let outputPath: String

	var textColor: Color
	var bannerColor: Color

	init(bannerText: String,
		 inputPath: String,
		 outputPath: String,
		 textColor: Color = .white,
		 bannerColor: Color = .red) {
		self.bannerText = bannerText
		self.inputPath = inputPath
		self.outputPath = outputPath
		self.textColor = textColor
		self.bannerColor = bannerColor
	}

}

extension MagickCommand {

	var string: String {
		return """
			magick \
				\(inputPath) \
				-set filename:input "%t" \
				-gravity South \
				-fill "rgb(\(textColor.rawValue))" \
				-undercolor "rgb(\(bannerColor.rawValue))" \
				-pointsize "%[fx:h/5]" \
				-annotate +0+0 "\\        \(bannerText)        " \
				\(outputPath)
			"""
	}

}
