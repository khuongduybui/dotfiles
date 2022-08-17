#! /usr/bin/env sh

pip install -U pipx
asdf reshim
mkdir -p /home/duybui/.virtualenvs
pipx install virtualfish
pipx ensurepath
fish -c "vf install"
fish -c "vf addplugins auto_activation"
pipx upgrade-all

cargo install difftastic

asdf reshim

curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

gh extension install mislav/gh-branch
