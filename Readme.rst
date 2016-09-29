pub2
====

Pub2 is a self-publishing framework.

.. image:: https://img.shields.io/github/stars/iandennismiller/pub2.svg?style=social&label=GitHub
    :target: https://github.com/iandennismiller/pub2

.. image:: https://img.shields.io/pypi/v/pub2.svg
    :target: https://pypi.python.org/pypi/pub2

.. image:: https://readthedocs.org/projects/pub2/badge/?version=latest
    :target: http://pub2.readthedocs.io/en/latest/?badge=latest
    :alt: Documentation Status

.. image:: https://travis-ci.org/iandennismiller/pub2.svg?branch=master
    :target: https://travis-ci.org/iandennismiller/pub2

.. image:: https://coveralls.io/repos/github/iandennismiller/pub2/badge.svg?branch=master
    :target: https://coveralls.io/github/iandennismiller/pub2?branch=master

Overview
--------

Pub2 is a self-publishing framework.  It integrates with Jekyll to provide LaTeX publishing.

Installation
^^^^^^^^^^^^

Homebrew
~~~~~~~~

::

    brew install https://raw.githubusercontent.com/iandennismiller/pub2/master/etc/pub2.rb
    brew cask install mactex

Python pip
~~~~~~~~~~

::

    pip install pub2

Usage
^^^^^

Create a new folder and switch to it.  The following will initialize the folder and render a sample document.

::

    pub2 init
    pub2 build

Documentation
^^^^^^^^^^^^^

http://pub2.readthedocs.io
