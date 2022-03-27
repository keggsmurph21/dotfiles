#!/bin/bash
# shellcheck disable=1090,2086

if [[ "$SH_ENV" != vim ]]; then
    cat <<BEANS
 _______________
< what's beadly >
 ---------------
        \\   ^__^
         \\  (oo)\\_______
            (__)\\       )\\/\\
                ||----w |
                ||     ||
BEANS
fi

source $HOME/.bashrc
