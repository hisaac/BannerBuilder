// Created by Isaac Halvorson on 11/14/18

/// 🌈 Colors based on Apple's [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/)
enum Color {

	case red
	case orange
	case yellow
	case green
	case tealBlue
	case blue
	case purple
	case pink
	case black
	case white
	case customRGB(_ rgbString: String)
	case customHex(_ hexString: String)

}

extension Color {

	init(rawValue: String) {
		switch rawValue {
		case "red": self = .red
		case "orange": self = .orange
		case "yellow": self = .yellow
		case "green": self = .green
		case "teal",
			 "tealBlue": self = .tealBlue
		case "blue": self = .blue
		case "purple": self = .purple
		case "pink": self = .pink
		case "black": self = .black
		case "white": self = .white
		default: self = .red
		}
	}

	var rgbString: String {
		switch self {
		case .red:      return "255,59,48"
		case .orange:   return "255,149,0"
		case .yellow:   return "255,204,0"
		case .green:    return "76,217,100"
		case .tealBlue: return "90,200,250"
		case .blue:     return "0,122,255"
		case .purple:   return "88,86,214"
		case .pink:     return "255,45,85"
		case .black:    return "0,0,0"
		case .white:    return "255,255,255"

		case .customRGB(let rgbString):
			return rgbString

		case .customHex(let hexString):
			return Color.hexToRGB(hexString) ?? Color.black.rgbString
		}
	}

	/// Converts a hexidecimal color string to an RGB color string
	static func hexToRGB(_ hexString: String) -> String? {
		var hexNumbers = hexString

		if hexString.first == "#" {
			hexNumbers.removeFirst()
		}

		guard let hexInteger = Int(hexNumbers) else { return nil }
		let red = (hexInteger >> 16) & 0xFF
		let green = (hexInteger >> 8) & 0xFF
		let blue = hexInteger & 0xFF
		return "\(red),\(green),\(blue)"
	}
}
