#!/bin/bash
# based on https://github.com/Homebrew/brew/blob/master/docs/Python-for-Formula-Authors.md#installing
# rebuild with 'make homebrew'

PKG=pub2

source $(brew --prefix)/bin/virtualenvwrapper.sh

# create virtualenv and install
mktmpenv
cd ~/Work/${PKG}
make install

# use poet to build pip package manifest
pip install homebrew-pypi-poet
poet ${PKG} > /tmp/poet.rb

# extract python package URL
URL=$(perl -n000e 'print $1 while /^..resource\s\"pub2\"\sdo\n\s+url\s\"(.*?)\"\n.*?\n..end\n\n/mg' /tmp/poet.rb)

# remove package resource from poet manifest
perl -0777 -i.original -pe 's/..resource\s\"pub2\"\sdo\n.*?\n.*?\n..end\n\n//igs' /tmp/poet.rb

# determine sha256 checksum for python package
curl -q -o /tmp/pkg.tgz ${URL}
SHA=$(shasum -a 256 /tmp/pkg.tgz | cut -d ' ' -f 1 -)
rm /tmp/pkg.tgz

# write header
cat > /tmp/pkg.rb <<-EOF
# Homebrew Formula
# pub2 (c) Ian Dennis Miller
# rebuild with 'make homebrew'

class Pub2 < Formula
  desc "Pub2 is a self-publishing framework"
  homepage "https://github.com/iandennismiller/pub2"
  url "${URL}"
  sha256 "${SHA}"
  depends_on "imagemagick"

EOF

# write poet manifest
cat /tmp/poet.rb >> /tmp/pkg.rb

# write footer
cat >> /tmp/pkg.rb <<-EOF

  include Language::Python::Virtualenv

  def install
    virtualenv_install_with_resources
  end
end
EOF

# exit virtualenv
deactivate

# finalize
mv /tmp/pkg.rb /tmp/${PKG}.rb
echo "created /tmp/${PKG}.rb"
