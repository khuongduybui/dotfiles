#! /bin/sh

sudo add-apt-repository -y ppa:teni-ime/ibus-teni
sudo apt-get update -y
sudo apt-get install -y ibus-teni
ibus restart
