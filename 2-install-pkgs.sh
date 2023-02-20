#!/bin/bash -e
VENV_HOME="$PWD/build/venv.orig"
export PATH="$VENV_HOME/bin:$VENV_HOME/Scripts:$PATH"
if [[ ! -d "$VENV_HOME" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Install the core packages.
pip install \
  'PyInstaller==5.8.0' \
  'PyYAML==6.0' \
  'Sphinx==6.1.3'

# Install the extensions.
pip install \
  'git+https://github.com/executablebooks/MyST-Parser.git@f02d40f77c0b8a628b38e6c914b5684b42cc75aa#egg=myst-parser' \
  'recommonmark==0.7.1' \
  'sphinxcontrib-httpdomain==1.8.1' \
  'sphinxcontrib-imagesvg==0.1' \
  'sphinxcontrib-openapi==0.8.1' \
  'sphinxcontrib-plantuml==0.24.1' 'Pillow==9.4.0' \
  'sphinxcontrib-redoc==1.6.0' \
  'sphinxcontrib-websupport==1.2.4' \
  'git+https://github.com/sphinx-contrib/youtube.git@6ac4730bae06fe34a2c3098653326e3d47bb045a#egg=sphinxcontrib.youtube' \
  'sphinxemoji==0.2.0' \
  'sphinx-markdown-tables==0.0.17'

# Install the themes.
pip install \
  'sphinx-bootstrap-theme==0.8.1' \
  'sphinx-rtd-theme==1.2.0'

# Delete compilation cache so it's easier to diff.
find "$VENV_HOME" -type d -name '__pycache__' -exec rm -fr {} ';' >/dev/null 2>&1 || true
