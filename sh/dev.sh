#! /usr/bin/env sh

# trunk-ignore(shellcheck/SC1090)
. ~/.asdf/asdf.sh

mkdir -p /home/duybui/.virtualenvs
pipx install virtualfish
pipx ensurepath
fish -c "vf install"
fish -c "vf addplugins auto_activation"
pipx upgrade-all

cargo install difftastic

asdf reshim
