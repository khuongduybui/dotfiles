#! /usr/bin/env sh

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install
~/dotfiles/install
