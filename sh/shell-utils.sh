#! /usr/bin/env sh

cd ~/dotfiles/shell-utils || exit
for script in scripts/*.ts; do
    deno install -f --no-check -A --reload "${HOME}/dotfiles/shell-utils/${script}"
done
if which deno | grep -q asdf; then
    asdf reshim
fi
