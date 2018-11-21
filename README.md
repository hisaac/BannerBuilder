# BannerBuilder

> Note: BannerBuilder is in active development, and is subject to change

BannerBuilder is a simple command line application for adding banners to your app icons, written entirely in Swift. It has been developed to be used for iOS development, but can be used for any other development that has an icon.

To use from the command line:

```shell
USAGE: bannerbuilder --input path/to/input --output path/to/output --bannerText DEV --bannerColor red

OPTIONS:
  --bannerColor, -c   The color of the banner. Can provide a color defined in the HIG, or RGB values in rrr,ggg,bbb format (e.g. 255,23,87)
  --bannerText, -t    The text you'd like to have displayed on the banner (Note: Currently only 3 or 4 character strings are supported)
  --input, -i         The file path containing the images you would like to add a banner to
  --output, -o        The file path to where you'd like the newly created images to end up
  --help              Display available options
```

To see the help menu, simply run `bannerbuilder` without any arguments, or include `-h` or `--help`.

## To Do

- [ ] Add support for `-r` flag for rotating banner vs flat banner
- [ ] Add to homebrew for installation
- [ ] Automatically determine output based on `.xcodeproj` file
- [ ] Use yaml file for configuration
- [ ] Write tests
