#! /usr/bin/env sh

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles || exit
git fetch
git reset --hard origin/main
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install

SHELL=bash ~/dotfiles/install --config-file prerequisites.conf.yaml
test -f /home/linuxbrew/.linuxbrew/bin/brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -f ~/.asdf/asdf.sh && . ~/.asdf/asdf.sh

SHELL=bash ~/dotfiles/install --plugin-dir dotbot-asdf --plugin-dir dotbot-brew
