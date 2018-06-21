#!/usr/bin/env bash


first_arg="$1"
shift 1;

export npmvv="$HOME/.npmv_stash/versions";
mkdir -p "$npmvv"

if [ "$first_arg" == "use" ]; then

    npmv_use "$@"

else

 echo "no command recognized";
fi
