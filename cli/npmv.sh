#!/usr/bin/env bash

export npmv_gray='\033[1;30m'
export npmv_magenta='\033[1;35m'
export npmv_cyan='\033[1;36m'
export npmv_orange='\033[1;33m'
export npmv_yellow='\033[1;33m'
export npmv_green='\033[1;32m'
export npmv_no_color='\033[0m'

zmx(){
	 "$@"  \
        2> >( while read line; do echo -e "${r2g_magenta}[${zmx_command_name}]${r2g_no_color} $line"; done ) \
        1> >( while read line; do echo -e "${r2g_gray}[${zmx_command_name}]${r2g_no_color} $line"; done )
}

first_arg="$1"
shift 1;

export npmvv="$HOME/.npmv_stash/versions";
mkdir -p "$npmvv"

if [ "$first_arg" == "use" ]; then

    export zmx_command_name="npmv/use"
    zmx npmv_use "$@"

elif [ "$first_arg" == "ls" ]; then

    export zmx_command_name="npmv/ls"
    zmx ls "$npmvv"
    zmx echo "Total number of installations: $(ls "$npmvv" | wc -l)"

elif [ "$first_arg" == "rm" ] || [ "$first_arg" == "remove" ]; then

    export zmx_command_name="npmv/rm"
    zmx npmv_rm "$@"

else

 echo "no command recognized, try (kk5 rm, kk5 use, kk5 install, kk5 ls)";

fi
