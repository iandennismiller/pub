# Homebrew Formula for Pub2
# pub2 (c) Ian Dennis Miller
# based on https://github.com/Homebrew/brew/blob/master/docs/Python-for-Formula-Authors.md

class Pub2 < Formula
  desc "Pub2 is a self-publishing framework"
  homepage "https://github.com/iandennismiller/pub2"
  url "https://files.pythonhosted.org/packages/b7/d3/2e9657021c1fb0a9379a5105e83507b3460dec7d53ef9ed4a9734e467eec/pub2-0.1.2.tar.gz"
  sha256 "601f96ae47716f2d23fdbc9455187b59bec70c9a26a2b13f830692624ac3b5d8"

  resource "click" do
    url "https://files.pythonhosted.org/packages/7a/00/c14926d8232b36b08218067bcd5853caefb4737cda3f0a47437151344792/click-6.6.tar.gz"
    sha256 "cc6a19da8ebff6e7074f731447ef7e112bd23adf3de5c597cf9989f2fd8defe9"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/e3/95/7e5d7261feb46c0539ac5e451be340ddd64d78c5118f2d893b052c76fe8c/gitdb-0.6.4.tar.gz"
    sha256 "a3ebbc27be035a2e874ed904df516e35f4a29a778a764385de09de9e0f139658"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/07/a6/87fc59935a67e26ad50cee5c731b6b133f1fb76d89028fe2d388f7349423/GitPython-1.0.1.tar.gz"
    sha256 "9c88c17bbcae2a445ff64024ef13526224f70e35e38c33416be5ceb56ca7f760"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/f2/2f/0b98b06a345a761bec91a079ccae392d282690c2d8272e708f4d10829e22/Jinja2-2.8.tar.gz"
    sha256 "bc1ff2ff88dbfacefde4ddde471d1417d3b304e8df103a7a9437d47269201bf4"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  resource "mr.bob" do
    url "https://files.pythonhosted.org/packages/05/43/7910606984c7a0259b383ec770da801de74da1f71612558b0aca2a311d02/mr.bob-0.1a9.zip"
    sha256 "fb88788ae77ced4025b2e737e227e63fec625a36b6265f37516efe904630fcb6"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"
    sha256 "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/bc/aa/b744b3761fff1b10579df996a2d2e87f124ae07b8336e37edc89cc502f86/smmap-0.9.0.tar.gz"
    sha256 "0e2b62b497bd5f0afebc002eda4d90df9d209c30ef257e8673c90a6b5c119d62"
  end

  include Language::Python::Virtualenv

  def install
    virtualenv_install_with_resources
  end
end
