#!/bin/bash -e
export PATH="$PWD/build/venv/bin:$PWD/build/venv/Scripts:$PATH"

# Install the core packages.
pip install \
  'PyInstaller==3.3.1' \
  'PyYAML==3.12' \
  'Sphinx==1.7.2'

# Install the extensions.
pip install \
  'javasphinx==0.9.15' \
  'recommonmark==0.4.0' \
  'sphinxcontrib-httpdomain==1.6.1' \
  'sphinxcontrib-inlinesyntaxhighlight==0.2' \
  'sphinxcontrib-plantuml==0.11'

# Install the themes.
pip install \
  'guzzle_sphinx_theme==0.7.11' \
  'sphinx_bootstrap_theme==0.6.5' \
  'sphinx_rtd_theme==0.3.0'

# Apply some patches and recompile the patched files.
PATCH_DIR="$PWD/patches"
if [[ -d build/venv/Lib/site-packages ]]; then
  SITEPKG_DIR="build/venv/Lib/site-packages"
else
  SITEPKG_DIR="build/venv/lib/python3.6/site-packages"
fi
pushd "$SITEPKG_DIR"
patch -p1 < "$PATCH_DIR/sphinxcontrib-inlinesyntaxhighlight.diff"
rm -v sphinxcontrib/__pycache__/inlinesyntaxhighlight.*
python -m compileall sphinxcontrib
popd

# Build the binary.
python -OO -m PyInstaller \
  --noconfirm \
  --console \
  --onefile \
  --additional-hooks-dir=hooks \
  run_sphinx.py

# Rename the binary.
OS_CLASSIFIER="$(./os_classifier.sh)"
if [[ -f dist/run_sphinx ]]; then
  SPHINX_BIN="dist/sphinx.$OS_CLASSIFIER"
  mv -v dist/run_sphinx "$SPHINX_BIN"
else
  SPHINX_BIN="dist/sphinx.$OS_CLASSIFIER.exe"
  mv -v dist/run_sphinx.exe "$SPHINX_BIN"
fi

# Generate the SHA256 checksum.
sha256sum -b "$SPHINX_BIN" > "$SPHINX_BIN.sha256"

# Build a test site with the binary to make sure it really works.
"dist/sphinx.$OS_CLASSIFIER" test_site build/test_site
