#! /usr/bin/env sh

shell=$1
if ! which "$shell"; then
    exit
fi
shell_path=$(which "$shell")
if ! grep -q /etc/shells -e "^$shell_path$"; then
    echo "$shell_path" | sudo tee -a /etc/shells
fi
sudo chsh -s "$shell_path" "$USER"
