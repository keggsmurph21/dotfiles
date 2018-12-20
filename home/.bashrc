#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ ! -z $BASH ]; then

    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\]\h:\[\033[01;34m\]\W \[\033[00m\]\$ '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[00m\]\$ '
    fi

    source $HOME/.shrc

fi
