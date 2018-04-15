#!/bin/bash -e
if [[ "$(uname)" =~ ([Ll]inux) ]]; then
  echo linux-x86_64
elif [[ "$(uname)" =~ ([Dd]arwin) ]]; then
  echo osx-x86_64
elif [[ -n "$APPVEYOR" ]]; then
  if [[ "$APPVEYOR_BITS" == '32' ]]; then
    echo windows-x86_32
  else
    echo windows-x86_64
  fi
else
  echo unknown
fi
