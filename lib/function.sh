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