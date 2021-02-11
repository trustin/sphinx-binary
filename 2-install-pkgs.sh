#!/bin/bash -e
VENV_HOME="$PWD/build/venv.orig"
export PATH="$VENV_HOME/bin:$VENV_HOME/Scripts:$PATH"
if [[ ! -d "$VENV_HOME" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Install the core packages.
pip install \
  'PyInstaller==4.2' \
  'PyYAML==5.4.1' \
  'Sphinx==3.4.3'

# Install the extensions.
pip install \
  'recommonmark==0.7.1' \
  'sphinxcontrib-httpdomain==1.7.0' \
  'sphinxcontrib-imagesvg==0.1' \
  'sphinxcontrib-openapi==0.7.0' \
  'sphinxcontrib-plantuml==0.19' 'Pillow==8.1.0' \
  'sphinxcontrib-redoc==1.6.0' \
  'sphinxcontrib-websupport==1.2.4' \
  'git+https://github.com/sphinx-contrib/youtube.git@635c8a908e3cac552ce43293c1516e7270cc4ce8#egg=sphinxcontrib.youtube' \
  'sphinxemoji==0.1.8' \
  'sphinx-markdown-tables==0.0.15'

# Install the themes.
pip install \
  'git+https://github.com/ryan-roemer/sphinx-bootstrap-theme.git@a6dfc6f9054f6b4cf3eb1acadf715a679ed53a7b#egg=sphinx_bootstrap_theme' \
  'sphinx_rtd_theme==0.5.1'

# Delete compilation cache so it's easier to diff.
find "$VENV_HOME" -type d -name '__pycache__' -exec rm -fr {} ';' >/dev/null 2>&1 || true
