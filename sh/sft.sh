#! /usr/bin/env sh

if ! which sft >/dev/null 2>&1; then
    # https://www.scaleft.com/docs/sft-ubuntu/
    echo "deb http://pkg.scaleft.com/deb linux main" | sudo tee /etc/apt/sources.list.d/scaleft.list
    curl -C - https://dist.scaleft.com/pki/scaleft_deb_key.asc | sudo apt-key add -
    sudo apt -y update
    sudo apt -y install scaleft-client-tools
fi
