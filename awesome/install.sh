#!/bin/bash

sudo apt install neovim git alacritty curl jq calcurse
sudo apt fonts-recommended fonts-font-awesome fonts-terminus
sudo apt install pavucontrol pulsemixer pamixer pipewire-audio
sudo apt build-dep awesome
sudo apt install libxcd-xfixes0-dev

git clone https://github.com/awesomewm/awesome
make
sudo make install

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
