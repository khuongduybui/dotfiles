#! /usr/bin/env sh

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles || exit
git fetch
git reset --hard origin/main
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install
~/dotfiles/install --plugin-dir dotbot-brew --plugin-dir dotbot-asdf
sudo ~/dotfiles/install -p dotbot-apt/apt.py -c ~/dotfiles/packages.conf.yaml
