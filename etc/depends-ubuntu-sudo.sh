#!/bin/bash
# pub2 (c) Ian Dennis Miller

# This script is useful for supporting a Jekyll installation on Ubuntu 12.04 LTS.
# This will install a specific version of Ruby, update pip and virtualenvwrapper,
# and install TeX Live using Scott Kosty's script.
#
# This script must be run as root.

# ensure rvm is installed
curl -sSL https://get.rvm.io | bash -s stable --ruby

# install Ruby 2.3.0
rvm install 2.3.0
rvm use 2.3.0
rvm rubygems latest

# ensure bundler is installed
gem install bundler

# ensure pip is current
pip install -U pip

# ensure virtualenvwrapper is installed
pip install -U virtualenv virtualenvwrapper

# install imagemagick / magickwand
apt-get -y install libmagickwand-dev

# install TeX Live (currently 2016)
wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu
chmod +x ./install-tl-ubuntu
./install-tl-ubuntu
