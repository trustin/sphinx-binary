#!/bin/bash -e
export PATH="$PWD/build/venv/bin:$PWD/build/venv/Scripts:$PATH"
if [[ ! -d "$PWD/build/venv" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Install the core packages.
pip install \
  'PyInstaller==3.6' \
  'PyYAML==5.3.1' \
  'Sphinx==2.4.4'

# Install the extensions.
pip install \
  'recommonmark==0.6.0' \
  'sphinxcontrib-httpdomain==1.7.0' \
  'sphinxcontrib-imagesvg==0.1' \
  'sphinxcontrib-openapi==0.6.0' \
  'sphinxcontrib-plantuml==0.18' 'Pillow==7.0.0' \
  'sphinxcontrib-redoc==1.5.1' \
  'sphinxcontrib-websupport==1.1.2' \
  'git+https://github.com/sphinx-contrib/youtube.git@f321c6720647c68e85777b714f80cefedb05e6df#egg=sphinxcontrib.youtube' \
  'sphinxemoji==0.1.4' \
  'sphinx-markdown-tables==0.0.12'

# Install the themes.
pip install \
  'sphinx_bootstrap_theme==0.7.1' \
  'sphinx_rtd_theme==0.4.3'
