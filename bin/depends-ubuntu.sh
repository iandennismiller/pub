#!/usr/bin/bash

# install TeX Live
wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu
chmod +x ./install-tl-ubuntu
echo "now install as root.  This will request sudo access"
sudo ./install-tl-ubuntu
