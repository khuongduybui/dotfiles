#! /usr/bin/env sh

if ! test -f /home/linuxbrew/.linuxbrew/bin/brew; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
    echo "/home/linuxbrew/.linuxbrew/bin/brew shellenv | source; or true" >~/.config/fish/conf.d/brew.fish
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.profile
else
    /home/linuxbrew/.linuxbrew/bin/brew update
fi
