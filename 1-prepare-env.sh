#!/bin/bash -e
cd "$(dirname "$0")"
rm -fr build

# Install or find Python 3.6 or 3.7.
if [[ "$(uname)" =~ ([Ll]inux) ]]; then
  # Note that we can upgrade to 3.7 only after upgrading from Trusty to Xenial.
  # See: https://github.com/deadsnakes/issues/issues/63
  if [[ "$TRAVIS_OS_NAME" == 'linux' ]]; then
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install -y python3.6 python3.6-venv python3.6-dev
  fi
  if [[ -x /usr/bin/python3.7 ]]; then
    PYTHON=/usr/bin/python3.7
  else
    PYTHON=/usr/bin/python3.6
  fi
elif [[ "$(uname)" =~ ([Dd]arwin) ]]; then
  if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew install python
  fi
  PYTHON=/usr/local/bin/python3
elif [[ -n "$APPVEYOR" ]]; then
  if [[ "$(./os_classifier.sh)" == 'windows-x86_32' ]]; then
    PYTHON=/c/Python37/python
  else
    PYTHON=/c/Python37-x64/python
  fi
else
  echo "Unsupported build environment: $(uname -a)"
  exit 1
fi

# Create and activate a virtualenv.
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

# Make sure we use Python 3.6 or 3.7.
PYVER="$(python --version)"
PIPVER="$(pip --version)"
echo "$(which python) --version: $PYVER"
echo "$(which pip) --version: $PIPVER"
echo "os.classifier: $(./os_classifier.sh)"
if [[ ! "$PYVER" =~ (^Python 3\.[67]\.) ]] || \
   [[ ! "$(which python)" =~ (^.*/build/venv/.*$) ]] || \
   [[ ! "$PIPVER" =~ (^.*pip [1-9][0-9]+\..*[\\/]build[\\/]venv[\\/].*3\.[67][^0-9].*$) ]]; then
  echo 'Must run on Python 3.6 or 3.7 virtualenv with pip 10+'
  exit 1
fi
