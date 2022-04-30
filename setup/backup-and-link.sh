#! /bin/bash

source="$1"
destination="$2"
[[ $2 =~ /$ ]] && destination="$2$(basename $1)"
sudo rm -rf "$destination.$(date +%Y-%m-%d).bak"
test -L "$destination" && sudo rm -f "$destination"
test -e "$destination" && sudo mv "$destination" "$destination.$(date +%Y-%m-%d).bak"
sudo ln -s "$source" "$destination"
