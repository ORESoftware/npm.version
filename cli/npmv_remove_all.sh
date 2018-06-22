#!/usr/bin/env bash

set -e;

npm install -g npm@latest -s || {
  echo -e >&2 "Could not install latest version of NPM.";
  echo -e >&2 "To install a different version of NPM, use --replace-with='x'.";
  exit 1;
}

rm -rf "$npmvv";
mkdir -p "$npmvv";
echo "Total number of installations: $(ls "$npmvv" | wc -l)"
