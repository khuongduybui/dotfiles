#! /usr/bin/env sh

# From https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
curl -s "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
if [ -f "/tmp/session-manager-plugin.deb" ]; then
    sudo dpkg -i "/tmp/session-manager-plugin.deb"
    sudo apt-get install -f
    rm "/tmp/session-manager-plugin.deb"
fi
