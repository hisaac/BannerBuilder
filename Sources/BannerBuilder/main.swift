// Created by Isaac Halvorson on 11/14/18

import BannerBuilderCore

do {
	try BannerBuilder().run()
} catch {
	print("Whoops! An error occurred: \(error)")
}
