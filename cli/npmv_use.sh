#!/usr/bin/env bash

set -e;
desired_npm_version="$1"

if [ -z "$desired_npm_version" ]; then
  echo >&2 "No desired npm version provided.";
  exit 1;
fi

desired_v="$npmvv/$desired_npm_version"

if [ ! -d "$desired_v" ]; then

  mkdir -p "$desired_v";
  cd "$desired_v";
  npm init -f --silent;
  mkdir -p node_modules;
  npm install "npm@$desired_npm_version" -f --silent

fi

echo "npm root: $(npm root -g)"

cd "$npmvv/$desired_npm_version";

npm_root="$(npm root -g)";
npm_bin="$(npm bin -g)";

rm -rf "$npm_root/npm";
rm -rf "$npm_bin/npm";
rm -rf "$npm_bin/npx";

ln -sf node_modules/npm "$npm_root"
#ln -sf node_modules/.bin/npm  "$npm_bin/npm"
#ln -sf node_modules/.bin/npx  "$npm_bin/npx"

