#!/usr/bin/bash
# pub2 (c) Ian Dennis Miller

# This script is useful for supporting a Jekyll installation on Ubuntu 12.04 LTS.
# It will create local versions of Ruby and Python modules.  This script is intended
# for unprivileged execution.  It has a counterpart called depends-ubuntu-sudo.sh
# that must be run with root privileges.

# for Jekyll
source /usr/local/rvm/scripts/rvm
bundle install --path vendor/bundle

# for Pub2
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv -a . -r requirements.txt pub2
source ~/.virtualenvs/pub2/bin/activate
