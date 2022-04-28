#! /usr/bin/env sh

if [ ! -e /etc/sudoers.d/$USER ]; then
  psw=$(whiptail --passwordbox "Enter your sudo password to continue." 8 64 3>&1 1>&2 2>&3)
  echo $psw | sudo -S mkdir -p /etc/sudoers.d
  echo "$USER ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER > /dev/null
fi
