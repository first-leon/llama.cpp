#!/bin/bash

if [[ ${BASH_SOURCE[0]} -ef $0 ]]; then
   echo >&2 "This script should be sourced, not executed!"
   exit 1
fi

readonly _OK=0
readonly _ERR=1

_Log() {
    local level=$1 msg=$2
    printf >&2 '%s: %s\n' "$level" "$msg"
}

_LogDebug() {
    _Log DEBUG "$@"
}

_LogInfo() {
    _Log INFO "$@"
}

_LogFatal() {
    _Log FATAL "$@"
    exit 1
}

# Return true if the variable with name $1 is set
_IsSet() {
    (( $# != 1 )) && return $_ERR
    if [[ -n ${!1+x} ]]; then
        return $_OK
    else
        return $_ERR
    fi
}

_IsNotSet() {
    ! _IsSet "$@"
}

_SnakeToPascalCase() {
    (( $# != 1 )) && return $_ERR
    local IFS='_'
    local pascal=''
    for word in $1; do
        local head; head=$(tr '[:lower:]' '[:upper:]' <<< "${word:0:1}")
        local tail=${word:1}
        pascal+="$head$tail"
    done
    echo -n "$pascal"
}
