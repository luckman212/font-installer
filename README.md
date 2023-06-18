<img src='icon.png' width='15%'>

# font-installer

A small shell script to automate font installation on macOS.

In its current form, the script fetches the latest version of the JetBrains-Mono font from its [GitHub repo](https://github.com/JetBrains/JetBrainsMono), compares it with the locally-installed version and (if the versions don't match) downloads and installs the fonts.

Requires [Homebrew](https://brew.sh) to be installed.

Feel free to modify as needed.

Based on [this StackExchange post](https://apple.stackexchange.com/questions/460745/how-to-install-a-large-set-of-ttf-fonts).
