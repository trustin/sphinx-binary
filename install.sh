#!/bin/bash -e
cd "$(dirname "$0")"
rm -fr build

# Install or find Python 3.6.
# Note that we can upgrade to 3.7 only after upgrading from Trusty to Xenial.
# See: https://github.com/deadsnakes/issues/issues/63
if [[ "$(uname)" =~ ([Ll]inux) ]]; then
  if [[ "$TRAVIS_OS_NAME" == 'linux' ]]; then
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install -y python3.6 python3.6-venv python3.6-dev
  fi
  PYTHON=/usr/bin/python3.6
elif [[ "$(uname)" =~ ([Dd]arwin) ]]; then
  if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
    #BREW_REPO="$(brew --repo homebrew/core)"
    #echo "Updating $BREW_REPO"
    #git -C "$BREW_REPO" fetch --unshallow
    #brew update
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew uninstall --ignore-dependencies --force python || true
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/f2a764ef944b1080be64bd88dca9a1d80130c558/Formula/python.rb
  fi
  PYTHON=/usr/local/bin/python3
elif [[ -n "$APPVEYOR" ]]; then
  if [[ "$(./os_classifier.sh)" == 'windows-x86_32' ]]; then
    PYTHON=/c/Python36/python
  else
    PYTHON=/c/Python36-x64/python
  fi
else
  echo "Unsupported build environment: $(uname -a)"
  exit 1
fi

# Create and activate a Python 3.6 virtualenv.
echo "Creating a new virtualenv with $PYTHON"
"$PYTHON" -m venv build/venv
export PATH="$PWD/build/venv/bin:$PWD/build/venv/Scripts:$PATH"

# Upgrade pip and setuptools.
if [[ -n "$APPVEYOR" ]]; then
  # Windows
  python -m pip install --upgrade pip setuptools
else
  pip install --upgrade pip setuptools
fi

# Make sure we use Python 3.6.
PYVER="$(python --version)"
PIPVER="$(pip --version)"
echo "$(which python) --version: $PYVER"
echo "$(which pip) --version: $PIPVER"
echo "os.classifier: $(./os_classifier.sh)"
if [[ ! "$PYVER" =~ (^Python 3\.6\.) ]] || \
   [[ ! "$(which python)" =~ (^.*/build/venv/.*$) ]] || \
   [[ ! "$PIPVER" =~ (^.*pip [1-9][0-9]+\..*[\\/]build[\\/]venv[\\/].*3\.6[^0-9].*$) ]]; then
  echo 'Must run on Python 3.6 virtualenv with pip 10+'
  exit 1
fi
