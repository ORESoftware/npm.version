#!/usr/bin/env bash

set -e;
desired_npm_version="$1"

mkdir -p "$HOME/.npmv_stash/versions";

#if [ -z "$(which read_json)" ]; then
#    npm install -g "@oresoftware/read.json" || {
#       echo "Could not install @oresoftware/read.json";
#       exit 1;
#    }
#fi

if [ -z "$desired_npm_version" ]; then
  echo >&2 "No desired npm version provided.";
  exit 1;
fi

current_npm_version="$(npm -v)";
read_link="$(readlink -f $(which npm))"

find "$HOME/.npmv_stash/versions" -type d -name "$desired_npm_version" | while read line; do

 npm_install_dir="$line";

 if [ "$read_link" == "$npm_install_dir"* ]; then
     echo "Found directory with your current npm version, will attempt to install new npm to replace it."
     npm install -g "$current_npm_version" || {
       echo "Could not install new npm version $current_npm_version";
       exit 1;
     }
 fi

 rm -r "$npm_install_dir";

  if [ "$?" == "0" ]; then

      echo "Removed installation at directory => $npm_install_dir";
  else
       echo >&2 "Could not remove dir => $npm_install_dir";
  fi


done


