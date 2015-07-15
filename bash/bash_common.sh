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