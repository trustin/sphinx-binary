#!/bin/bash -e
ORIG_VENV_HOME="$PWD/build/venv.orig"
NEW_VENV_HOME="$PWD/build/venv.new"

if [[ ! -d "$ORIG_VENV_HOME" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Revert the new venv so that we can patch from scratch.
rsync -aiP --delete "$ORIG_VENV_HOME/" "$NEW_VENV_HOME/"

# Make sure we don't refer to the old venv.
if grep -rFl "venv.orig" "$NEW_VENV_HOME"/[Ll]ib; then
  echo "The new virtualenv contains a reference to the old one."
  exit 1
fi

# Apply some patches.
export PATH="$NEW_VENV_HOME/bin:$NEW_VENV_HOME/Scripts:$PATH"
PATCH_DIR="$PWD/patches"
if [[ -d "$NEW_VENV_HOME/Lib/site-packages" ]]; then
  SITEPKG_DIR="$NEW_VENV_HOME/Lib/site-packages"
elif [[ -d "$NEW_VENV_HOME/lib/python3.10/site-packages" ]]; then
  SITEPKG_DIR="$NEW_VENV_HOME/lib/python3.10/site-packages"
fi
pushd "$SITEPKG_DIR"
if [[ ! -a sphinxcontrib/__init__.py ]]; then
  echo "__import__('pkg_resources').declare_namespace(__name__)" > sphinxcontrib/__init__.py
fi
find "$PATCH_DIR" -name '*.diff' -print | while read -r PATCH; do
  patch -p1 -i "$PATCH"
done
find . -type f -name '*.orig' -delete || true

# Pre-compile everything unless 'nocompile' option is specified.
if [[ "$1" != 'nocompile' ]]; then
  find . -type d -name '__pycache__' -exec rm -fr {} ';' >/dev/null 2>&1 || true
  python -m compileall . >/dev/null 2>&1
fi
popd
