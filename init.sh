#! /usr/bin/env bash

test -d ~/dotfiles || git clone https://github.com/khuongduybui/dotfiles.git/ ~/dotfiles
cd ~/dotfiles || exit
git fetch
git reset --hard origin/main
git submodule update --init --recursive
rm -f ~/dotfiles/install
cp dotbot/tools/git-submodule/install ~/dotfiles/install

# trunk-ignore(shellcheck/SC2088)
SHELL=bash bash -l -c '~/dotfiles/install --config-file prerequisites.conf.yaml'
# trunk-ignore(shellcheck/SC2312)
test -f /home/linuxbrew/.linuxbrew/bin/brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# trunk-ignore(shellcheck/SC1090)
test -f ~/.asdf/asdf.sh && . ~/.asdf/asdf.sh
sudo apt-get install -y unzip xdg-utils
# trunk-ignore(shellcheck/SC2015)
grep -q -i "Microsoft" /proc/version && sudo apt-get install -y wslu || true
sudo apt-get install -y direnv fzf yq gh micro
# trunk-ignore(shellcheck/SC2088)
SHELL=bash bash -l -c '~/dotfiles/install --plugin-dir dotbot-asdf --plugin-dir dotbot-brew'
echo "missing gitsign"