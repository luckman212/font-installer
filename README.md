<img src='icon.png' width='15%'>

# font-installer

## What is this

A small shell script to automate font installation on macOS.

In its current form, the script fetches the latest version of the JetBrains-Mono font from its [GitHub repo](https://github.com/JetBrains/JetBrainsMono), compares it with the locally-installed version and (if the versions don't match) downloads and installs the fonts.

## How to use

1. Download [the script](https://raw.githubusercontent.com/luckman212/font-installer/main/install-jetbrainsmono.sh)
2. Open a Terminal and make it executable: `chmod +x install-jetbrainsmono.sh`
3. Execute it: `./install-jetbrainsmono.sh`

## Notes

- Requires [Homebrew](https://brew.sh) to grab the 2 dependencies (`jq` to parse the GitHub API response and `otfinfo` to check the local font version info)
- Feel free to modify as needed
- Based on [this StackExchange post](https://apple.stackexchange.com/questions/460745/how-to-install-a-large-set-of-ttf-fonts)
