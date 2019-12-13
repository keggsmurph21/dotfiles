#!/bin/bash
#
# Kevin Murphy
# 9/25/19

# only use for interactive shells
[[ $- == *i* ]] || return

function __back_init() {
    local back_dir=~/.cache/back/$$
    mkdir -p $back_dir
    export BACKSTACK=$back_dir/back
    export FWSTACK=$back_dir/fw
    touch $BACKSTACK $FWSTACK
}

function __back_exit() {
    rm -rf $(dirname $BACKSTACK)
}

function __back_debug() {
    echo "@ $BACKSTACK:"
    cat $BACKSTACK
    echo "@ $FWSTACK:"
    cat $FWSTACK
}

function __cd() {
    builtin cd $1
}

function cd() {
    current="$(pwd)"
    __cd "$1" || return
    echo "$current" >> $BACKSTACK
    rm $FWSTACK
    touch $FWSTACK
}

function back() {
    if [ -s $BACKSTACK ]; then
        target="$(tail -n1 $BACKSTACK)"
        if [ -d "$target" ]; then
            pwd >> $FWSTACK
            __cd "$target"
        else
            echo "directory no longer exists: $target, skipping..." >&2
        fi
        sed -i '$ d' $BACKSTACK
    else
        echo "cannot go back any farther" >&2
    fi
}

function fw() {
    if [ -s $FWSTACK ]; then
        target="$(tail -n1 $FWSTACK)"
        if [ -d "$target" ]; then
            pwd >> $BACKSTACK
            __cd "$target"
        else
            echo "directory no longer exists: $target, skipping..." >&2
        fi
        sed -i '$ d' $FWSTACK
    else
        echo "cannot go fw any farther" >&2
    fi
}

__back_init             # initialize
trap __back_exit EXIT   # clean up
