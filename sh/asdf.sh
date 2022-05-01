#! /usr/bin/env sh

if [ ! -d ~/.asdf ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi
# shellcheck disable=SC1090
. ~/.asdf/asdf.sh
mkdir -p ~/.config/fish/completions
cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
asdf update
asdf plugin update --all

sudo apt install -y pkg-config make build-essential
sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt install -y librust-openssl-dev libssl-dev

# if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
#     mv /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/bin.bak
# fi
