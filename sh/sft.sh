#! /usr/bin/env sh

# https://www.scaleft.com/docs/sft-ubuntu/
echo "deb http://pkg.scaleft.com/deb linux main" | sudo tee /etc/apt/sources.list.d/scaleft.list
curl -C - https://dist.scaleft.com/pki/scaleft_deb_key.asc | sudo apt-key add -
sudo apt update
sudo apt install scaleft-client-tools
