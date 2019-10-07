#!/bin/bash

RED='\033[0;31m'        # Red
GRE='\033[0;32m'        # Green
YEL='\033[1;33m'        # Yellow
NCL='\033[0m'           # No Color

file_specification() {
        FILE_NAME="$(basename "${entry}")"
        COUNT="$(wc -w "${entry}" | cut -d' ' -f1)"

        printf "%*s${GRE}%s${NCL}\n"                    $((indent+4)) '' "${entry}"
        printf "%*s\tFile name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        printf "%*s\tWord count:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$COUNT"
}

walk() {
        local indent="${2:-0}"
        printf "\n%*s${RED}%s${NCL}\n\n" "$indent" '' "$1"

        for entry in "$1"/*; do [[ -f "$entry" ]] && file_specification; done

        for entry in "$1"/*; do [[ -d "$entry" ]] && walk "$entry" $((indent+4)); done
}

[[ -z "${1}" ]] && ABS_PATH="${PWD}" || cd "${1}" && ABS_PATH="${PWD}"
walk "${ABS_PATH}"
echo  
