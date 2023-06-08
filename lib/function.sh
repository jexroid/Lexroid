#!/bin/bash


_path_completion() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "-h --help" -- ${cur}) )
        return 0
    fi
    COMPREPLY=( $(compgen -d ${cur}) )
    return 0
}

function banner() {
    printf "  _     _______  ______   ___ ___ ____  \n"
    printf " | |   | ____\ \/ /  _ \ / _ \_ _|  _ \ \n"
    printf " | |   |  _|  \  /| |_) | | | | || | | |\n"
    printf " | |___| |___ /  \|  _ <  |_| | || |_| |\n"
    printf " |_____|_____/_/\_\_| \_|\___/___|____/ \n"
    printf "                                        \n"
    printf "                         version : 1.0.0\n\n"
}
