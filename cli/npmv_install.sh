#!/usr/bin/env bash

set -e;

my_args=( "$@" );

desired_npm_version="$1"
export npmvv="$HOME/.npmv_stash/versions"
mkdir -p "$npmvv";

if [ -z "$desired_npm_version" ]; then
  echo >&2 "No desired npm version provided.";
  exit 1;
fi

## --reinstall flag => will reinstall version if that version already exists on the fs

has_latest="no";
if npmv_match_arg "--latest" "${my_args[@]}"; then
    has_latest="yes";
fi

has_reinstall="no";
if npmv_match_arg "--reinstall" "${my_args[@]}"; then
    has_reinstall="yes";
fi


if [ -z "$desired_npm_version" ]; then
  echo >&2 "No desired npm version provided.";
  exit 1;
fi

echo "checking to see if version matching $desired_npm_version* exists...";
ver="";

if [[ "$has_latest" != "yes" ]]; then
    ver="$(find "$npmvv" -type d -name "$desired_npm_version"* | sort | tail -n 1)"
fi

if [ -z "$ver" ]; then

    echo "Going to NPM to find the latest version that matches: $desired_npm_version";
    ver="$(npm view --json "npm@$desired_npm_version" version | kk5_parse_json)"

    if [ -n "$ver" ]; then
        echo "latest version found on npm => $ver";
    fi

else
   ver="$(basename "$ver")"
   echo "Found existing matching version $ver"
fi

if [ -z "$ver" ]; then
  echo "Could not find an actual npm version corresponding to: $desired_npm_version";
  exit 1;
fi

desired_npm_version="$ver"
desired_v="$npmvv/$desired_npm_version"

if [ -d "$desired_v" ] && [ "$has_reinstall" != "yes" ]; then
   echo "Version $desired_npm_version is already installed. To force reinstall, use the '--reinstall' flag.";
   echo "To switch to this version use: 'npmv use $desired_npm_version'"
   exit 0;
fi


mkdir -p "$desired_v";
cd "$desired_v";
echo "Installing new npm version: $desired_npm_version"
npm init -f &> /dev/null;
mkdir -p node_modules;
npm install --save "npm@$desired_npm_version" -f -s || {
  echo "Could not install new npm version";
  exit 1;
}

echo "To switch to this version run: 'npmv use $desired_npm_version'"
echo "To do all of this in one step you can use: 'npmv use $desired_npm_version --latest'"
