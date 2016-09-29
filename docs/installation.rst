Installation
============

pub2 depends on TeX Live and ImageMagick.  To install, use either Homebrew (OSX) or pip (OSX, Linux, or Windows).

OSX Homebrew
^^^^^^^^^^^^

This is the suggested install method on OSX.

::

    brew cask install mactex
    brew install https://raw.githubusercontent.com/iandennismiller/pub2/master/etc/pub2.rb

OSX pip
^^^^^^^

The pip method works well with virtualenv.  For system-wide installation, use the homebrew method if possible.

Install mactex and imagemagick, then pub2.

::

    brew cask install mactex
    brew install imagemagick
    pip install pub2

Linux (Debian/Ubuntu)
^^^^^^^^^^^^^^^^^^^^^

Install magickwand-dev and texlive, then pub2.  Use virtualenv if you want.

::

    apt-get install libmagickwand-dev texlive
    pip install pub2

Linux (Redhat/CentOS)
^^^^^^^^^^^^^^^^^^^^^

Install imagemagck and texlive, then pub2.  Use virtualenv if you want.

::

    yum install ImageMagick-devel texlive-latex
    pip install pub2

Windows
^^^^^^^

1. Install TeX: http://mirror.ctan.org/systems/texlive/tlnet/install-tl-windows.exe
2. Install ImageMagick: http://docs.wand-py.org/en/0.4.3/guide/install.html#install-imagemagick-on-windows
3. Think happy thoughts.

::

    pip install pub2
