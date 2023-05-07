#! /usr/bin/env bash

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles || exit
git fetch
git reset --hard origin/main
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install

bash -l -c '~/dotfiles/install --config-file prerequisites.conf.yaml'
test -f /home/linuxbrew/.linuxbrew/bin/brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -f ~/.asdf/asdf.sh && . ~/.asdf/asdf.sh
sudo apt-get install -y unzip xdg-utils
grep -q -i "Microsoft" /proc/version && sudo apt-get install -y wslu || true
bash -l -c '~/dotfiles/install --plugin-dir dotbot-asdf --plugin-dir dotbot-brew'
