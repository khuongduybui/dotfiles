#! /usr/bin/env sh

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles || exit
git fetch
git reset --hard origin/main
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install

if test -f /home/linuxbrew/.linuxbrew/bin/brew; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
    echo "/home/linuxbrew/.linuxbrew/bin/brew shellenv | source; or true" >~/.config/fish/conf.d/brew.fish
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update

~/dotfiles/install --plugin-dir dotbot-asdf --plugin-dir dotbot-brew

