#!/usr/bin/env bash
EXPECTED_PYTHON_VERSION='3.10'

set -Eeuo pipefail
cd "$(dirname "$0")"
rm -fr build

# Ensure we're using the desired Python version.
PYTHON="$(which python)"
ACTUAL_PYTHON_VERSION="$("$PYTHON" --version)"
echo "$PYTHON --version: $ACTUAL_PYTHON_VERSION"
if [[ ! "$ACTUAL_PYTHON_VERSION" =~ (^Python 3\.10\.) ]]; then
  echo "Python $EXPECTED_PYTHON_VERSION is required."
  exit 1
fi

# Create and activate a virtualenv.
VENV_HOME="$PWD/build/venv.orig"
echo "Creating a new virtualenv with $PYTHON .."
"$PYTHON" -m venv "$VENV_HOME"

# Use the new Python and pip path after updating PATH.
export PATH="$VENV_HOME/bin:$VENV_HOME/Scripts:$PATH"
PYTHON="$(which python)"
PIP="$(which pip)"
if [[ ! "$PYTHON" =~ (^.*/build/venv\.orig/.*$) ]]; then
  echo "Unexpected python location: $PYTHON"
fi
if [[ ! "$PIP" =~ (^.*/build/venv\.orig/.*$) ]]; then
  echo "Unexpected pip location: $PIP"
fi

echo "Created a new virtualenv at $VENV_HOME"
echo "- Python: $PYTHON"
echo "- pip: $PIP"

# Upgrade pip and setuptools.
UNAME="$(uname)"
if [[ "${UNAME,,}" =~ (^(msys|cygwin)) ]]; then
  # Windows
  "$PYTHON" -m pip install --upgrade pip setuptools
else
  "$PIP" install --upgrade pip setuptools
fi

# Make sure we use Python 3.10.
ACTUAL_PYTHON_VERSION="$("$PYTHON" --version)"
ACTUAL_PIP_VERSION="$("$PIP" --version)"
echo "$PYTHON --version: $ACTUAL_PYTHON_VERSION"
echo "$PIP --version: $ACTUAL_PIP_VERSION"
echo "os.classifier: $(./os_classifier.sh)"
if [[ ! "$ACTUAL_PYTHON_VERSION" =~ (^Python 3\.10\.) ]] || \
   [[ ! "$ACTUAL_PIP_VERSION" =~ (^.*pip [1-9][0-9]+\..*[\\/]build[\\/]venv\.orig[\\/].*3\.10[^0-9].*$) ]]; then
  echo 'Must run on Python 3.10 virtualenv with pip 10+'
  exit 1
fi
