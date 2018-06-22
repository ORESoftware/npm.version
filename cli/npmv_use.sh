#!/usr/bin/env bash

set -e;

my_args=( "$@" );

npmv_match_arg(){
    # checks to see if the first arg, is among the remaining args
    # for example  ql_match_arg --json --json # yes
    first_item="$1"; shift;
    for var in "$@"; do
        if [[ "$var" == "$first_item" ]]; then
          return 0;
        fi
    done
    return 1;
}

has_latest="no";

if npmv_match_arg "--latest" "${my_args[@]}"; then
    has_latest="yes";
fi

desired_npm_version="$1"
export npmvv="$HOME/.npmv_stash/versions"

mkdir -p "$HOME/.npmv_stash/versions";

if [ -z "$desired_npm_version" ]; then
  echo >&2 "No desired npm version provided.";
  exit 1;
fi

echo "checking to see if version exists...";
#ver="$(npm view "npm@$desired_npm_version" version | tail -n 1 | sed "s/'/ /g")"

ver="";

if [[ "$has_latest" != "yes" ]]; then
    ver="$(find "$npmvv" -type d -name "$desired_npm_version"* | sort | tail -n 1)"
fi

if [ -z "$ver" ]; then

    echo "Going to NPM to find the latest version that matches: $desired_npm_version";
    ver="$(npm view --json "npm@$desired_npm_version" version | kk5_parse_json)"

    if [ -n "$ver" ]; then
        echo "latest version found on npm => $desired_npm_version";
    fi

else
   ver="$(basename "$ver")"
fi

if [ -z "$ver" ]; then
  echo "Could not find an actual npm version corresponding to: $desired_npm_version";
  exit 1;
fi

desired_npm_version="$ver"

#ver="$(node -pe "String('$ver').split(' ')[0].split('@')[1]")"
echo "will install this version now: $desired_npm_version"

desired_v="$npmvv/$desired_npm_version"

if [ ! -d "$desired_v" ]; then

  mkdir -p "$desired_v";
  cd "$desired_v";
  echo "Installing new npm version: $desired_v"
  npm init -f &> /dev/null;
  mkdir -p node_modules;
  npm install --save "npm@$desired_npm_version" -f -s || {
      echo "Could not install new npm version";
      exit 1;
   }
fi

echo "current npm version: $(npm -v)"
echo "npm root: $(npm root -g)"

cd "$npmvv/$desired_npm_version";

npm_root="$(npm root -g)";
npm_bin="$(npm bin -g)";

echo "pwd: $PWD"

rm -rf "$npm_root/npm";

ln -s "$PWD/node_modules/npm" "$npm_root/npm";

npm_source="$(readlink -f "$PWD/node_modules/.bin/npm")";
npx_source="$(readlink -f "$PWD/node_modules/.bin/npx")";

if [ ! -f "$npm_source" ]; then
   echo "npm file was not installed correctly.";
   exit 1;
fi


ln -sf  "$npm_source" "$npm_bin/npm"
ln -sf  "$npx_source" "$npm_bin/npx"

echo "Total number of installations: $(ls "$npmvv" | wc -l)"
echo "new npm version: $(npm -v)"
