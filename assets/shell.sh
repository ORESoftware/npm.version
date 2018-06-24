#!/usr/bin/env bash


npmv(){
  npv $@
}

kk5(){
  npv $@
}

npv(){

   if ! type -f npv &> /dev/null || ! which npv &> /dev/null; then

     npm i -s -g "@oresoftware/npv" || {
       echo >&2 "Could not install '@oresoftware/npv'...";
       echo >&2 "Please check your permissions to install global NPM packages.";
       return 1;
     }
  fi

  command npv $@;
}



export -f kk5;
export -f npv;
export -f npmv;
