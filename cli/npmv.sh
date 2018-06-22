#!/usr/bin/env bash


first_arg="$1"
shift 1;

export npmvv="$HOME/.npmv_stash/versions";
mkdir -p "$npmvv"

if [ "$first_arg" == "use" ]; then

    npmv_use "$@"

elif [ "$first_arg" == "rm" ] || [ "$first_arg" == "remove" ]; then

    npmv_rm "$@"

else

 echo "no command recognized";

fi
