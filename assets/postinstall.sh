#!/usr/bin/env bash

set -e;

if [[ "$npv_skip_postinstall" == "yes" ]]; then
  echo "skipping npv postinstall routine.";
  exit 0;
fi

export npv_skip_postinstall="yes";

if [[ "$oresoftware_local_dev" == "yes" ]]; then
    echo "Running the npv postinstall script in oresoftware local development env."
fi



mkdir -p "$HOME/.oresoftware/bash" || {
  echo "could not create oresoftware/bash dir."
  exit 1;
}


cat assets/shell.sh > "$HOME/.oresoftware/bash/npv.sh" || {
  echo "could not create oresoftware/bash/npv.sh file."
  exit 1;
}


(

    shell_file="node_modules/@oresoftware/shell/assets/shell.sh";
    [ -f "$shell_file" ] && cat "$shell_file" > "$HOME/.oresoftware/shell.sh" && {
        echo "Successfully copied @oresoftware/shell/assets/shell.sh to $HOME/.oresoftware/shell.sh";
        exit 0;
    }

    shell_file="../shell/assets/shell.sh";
    [ -f "$shell_file" ] &&  cat "../shell/assets/shell.sh" > "$HOME/.oresoftware/shell.sh" && {
        echo "Successfully copied @oresoftware/shell/assets/shell.sh to $HOME/.oresoftware/shell.sh";
        exit 0;
    }

    curl -H 'Cache-Control: no-cache' \
         "https://raw.githubusercontent.com/oresoftware/shell/master/assets/shell.sh?$(date +%s)" \
          --output "$HOME/.oresoftware/shell.sh" 2> /dev/null || {
           echo "curl command failed to read shell.sh";
           exit 1;
    }
)



echo; echo -e "${ores_green} => npmv was installed successfully.${ores_no_color}";
echo -e "Add the following line to your .bashrc/.bash_profile files:";
echo -e "${ores_cyan} . \"\$HOME/.oresoftware/shell.sh\"${ores_no_color}"; echo;



