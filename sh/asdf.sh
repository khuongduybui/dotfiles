#! /usr/bin/env sh

if [ ! -d ~/.asdf ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    mkdir -p ~/.config/fish/completions
    cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
    echo '. ~/.asdf/asdf.sh' >>~/.profile
else
    asdf update
    asdf plugin update --all
fi

sudo apt install -y pkg-config make build-essential
sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt install -y llvm || true
sudo apt install -y tk-dev || true
sudo apt install -y librust-openssl-dev || sudo apt install -y libssl-dev
