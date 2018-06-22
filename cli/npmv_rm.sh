#!/usr/bin/env bash

set -e;
desired_npm_version="$1"

export npmvv="$HOME/.npmv_stash/versions"
mkdir -p "$npmvv";

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
echo "Current npm version: $(npm -v)"
read_link="$(readlink -f $(which npm))"
echo "Current npm install location: $read_link";
echo "Current number of installations: $(ls "$npmvv" | wc -l)"

nothing_removed="yes";

while read line; do

 nothing_removed="no";
 npm_install_dir="$line";


 echo "Found a matching installation directory: $npm_install_dir";

 if [[ ${read_link} =~ ^$npm_install_dir ]]; then
     echo "Found directory with your current npm version, will attempt to install new npm to replace it."
     npm install -g "npm@$current_npm_version" || {
       echo -e "${npmv_magenta}Could not install new npm version $current_npm_version${npmv_no_color}";
       exit 1;
     }
 fi

 rm -r "$npm_install_dir";

  if [ "$?" == "0" ]; then
      echo -e "Removed installation at directory => $npm_install_dir";
  else
      echo -e >&2 "Could not remove dir => ${npmv_magenta}$npm_install_dir${npmv_no_color}";
  fi


done < <(find "$HOME/.npmv_stash/versions" -type d -name "$desired_npm_version")

if [[ "$nothing_removed" == "yes" ]]; then
   echo -e "${npmv_magenta}Zero npm installations were removed.${npmv_no_color}";
fi

echo "Number of installations remaining: $(ls "$npmvv" | wc -l)"
