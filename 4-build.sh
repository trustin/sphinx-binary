#!/bin/bash -e
VENV_HOME="$PWD/build/venv.new"
export PATH="$VENV_HOME/bin:$VENV_HOME/Scripts:$PATH"
if [[ ! -d "$VENV_HOME" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Build the binary.
python -OO -m PyInstaller \
  --noconfirm \
  --console \
  --onefile \
  --distpath build/dist \
  --specpath build \
  --additional-hooks-dir=hooks \
  run_sphinx.py

# Rename the binary.
OS_CLASSIFIER="$(./os_classifier.sh)"
if [[ -f build/dist/run_sphinx.exe ]]; then
  SPHINX_BIN="build/dist/sphinx.$OS_CLASSIFIER.exe"
  mv -v build/dist/run_sphinx.exe "$SPHINX_BIN"
else
  SPHINX_BIN="build/dist/sphinx.$OS_CLASSIFIER"
  mv -v build/dist/run_sphinx "$SPHINX_BIN"
fi

# Generate the SHA256 checksum.
if [[ -x /usr/local/bin/gsha256sum ]]; then
  SHA256SUM_BIN=/usr/local/bin/gsha256sum
else
  SHA256SUM_BIN=sha256sum
fi
"$SHA256SUM_BIN" -b "$SPHINX_BIN" | sed 's/ .*//g' > "$SPHINX_BIN.sha256"
echo "sha256sum: $(cat "$SPHINX_BIN.sha256") ($SPHINX_BIN.sha256)"

# Build a test site with the binary to make sure it really works.
"build/dist/sphinx.$OS_CLASSIFIER" -T test_site build/test_site
