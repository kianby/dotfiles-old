#!/bin/bash
# BASH common functions

function headline() {
    if [ -f /usr/bin/cowsay ]; then
        cowsay "$*"
    else
        echo "======================================================================"
        echo "$*"
        echo "======================================================================"
    fi
}

function pause(){
   read -p "$*"
}

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
silent() { "$@" >/dev/null 2>&1; }