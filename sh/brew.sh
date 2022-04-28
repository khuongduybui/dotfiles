#! /usr/bin/env sh

if ! which brew; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
else
  brew update
fi
if test -f /home/linuxbrew/.linuxbrew/bin/brew; then
  echo "/home/linuxbrew/.linuxbrew/bin/brew shellenv | source; or true" >~/.config/fish/conf.d/brew.fish
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_PREFIX
  export HOMEBREW_CELLAR
  export HOMEBREW_REPOSITORY
  export PATH
  export MANPATH
  export INFOPATH
fi
