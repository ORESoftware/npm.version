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
        2> >( while read line; do echo -e "${r2g_magenta}${zmx_command_name}${r2g_no_color} $line"; done ) \
        1> >( while read line; do echo -e "${r2g_gray}${zmx_command_name}${r2g_no_color} $line"; done )
}

first_arg="$1"
shift 1;

export zmx_command_name="[npmv/$first_arg]"
export npmvv="$HOME/.npmv_stash/versions";
mkdir -p "$npmvv"

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

export -f npmv_match_arg;
export -f zmx;


if [ "$first_arg" == "use" ]; then

    zmx npmv_use $@

elif [ "$first_arg" == "ls" ]; then

    zmx ls "$npmvv"
    zmx echo "Total number of installations: $(ls "$npmvv" | wc -l)"

elif [ "$first_arg" == "install" ]; then

    zmx npmv_install $@

elif [ "$first_arg" == "rm" ] || [ "$first_arg" == "remove" ]; then

    zmx npmv_rm $@

elif [ "$first_arg" == "rm-all" ] || [ "$first_arg" == "remove-all" ]; then

    zmx npmv_rm_all $@
else

 echo "no command recognized, try (kk5 rm, kk5 use, kk5 install, kk5 ls)";

fi


