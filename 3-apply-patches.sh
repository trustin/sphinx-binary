#!/bin/bash -e
export PATH="$PWD/build/venv/bin:$PWD/build/venv/Scripts:$PATH"
if [[ ! -d "$PWD/build/venv" ]]; then
  echo "virtualenv not ready"
  exit 1
fi

# Apply some patches and recompile the patched files.
PATCH_DIR="$PWD/patches"
if [[ -d build/venv/Lib/site-packages ]]; then
  SITEPKG_DIR="build/venv/Lib/site-packages"
elif [[ -d build/venv/lib/python3.7/site-packages ]]; then
  SITEPKG_DIR="build/venv/lib/python3.7/site-packages"
else
  SITEPKG_DIR="build/venv/lib/python3.6/site-packages"
fi
pushd "$SITEPKG_DIR"
if [[ ! -a sphinxcontrib/__init__.py ]]; then
  echo "__import__('pkg_resources').declare_namespace(__name__)" > sphinxcontrib/__init__.py
fi
find "$PATCH_DIR" -name '*.diff' -print | while read -r PATCH; do
  patch -p1 -i "$PATCH"
done
find . -type d -name '__pycache__' -exec rm -fr {} ';' >/dev/null 2>&1 || true
python -m compileall . >/dev/null 2>&1
popd
