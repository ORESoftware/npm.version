#!/usr/bin/env bash


npmv(){

  if [ -z "$(which npmv)" ]; then
     npm install -g "@oresoftware/npm.version" || {
       echo >&2 "Could not install '@oresoftware/npm.version'...";
       exit 1;
     }
  fi

  command npmv $@
}
