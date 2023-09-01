# Prelude {{{

# vim: foldmethod=marker:foldlevel=0
# shellcheck disable=SC2139

# If not running interactively or from Vim, don't do anything
[[ $- != *i* && "${SH_ENV:-}" != vim ]] && return

# start the ssh-agent
[[ $- == *i* ]] && eval "$(ssh-agent)" >/dev/null

# }}}

# Shell options {{{

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# }}}

# Other sources {{{

__src() {
    # shellcheck disable=SC2015,SC1090
    if [[ -r "$1" ]]; then
        source "$1"
    fi
}

__src "$HOME/.local/share/dotfiles/src/bash/setup-dotfiles-env"

# source external files
for file in "$DOTFILES_DIR/src/bash/"*; do
    __src "$file"
done
__src "/usr/share/bash-completion/bash_completion"
__src "$HOME/.tokens"
__src "$HOME/.local/bin/virtualenvwrapper_lazy.sh"
__src "$HOME/.opam/opam-init/init.sh"
__src "$NVM_DIR/nvm.sh"
__src "$NVM_DIR/bash_completion"
__src "$HOME/src/github/hub/etc/hub.bash_completion.sh"
case "$OSTYPE" in
    linux-gnu)  __src "$HOME/.bashrc.linux" ;;
    darwin*)    __src "$HOME/.bashrc.macos" ;;
    *)          echo "unrecognized OSTYPE: $OSTYPE" >&2 ;;
esac
__src "$HOME/.bashrc.local"

unset __src

# }}}

# History {{{

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="pwd"

# }}}

# Prompt {{{

__prompt_rc_color() {
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        echo -e '\e[01;32m' # bright green
    else
        echo -e '\e[0;32m' # normal green
    fi
}
PS1='\[`__prompt_rc_color`\]\h\[\e[0m\] \[\e[01;34m\]\w\[\e[0m\]\$ '

# }}}

# Exports {{{

export PATH="$HOME/.local/bin:$DOTFILES_DIR/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$PATH"
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export VIRTUALENVWRAPPER_SCRIPT=~/.local/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME=~/.virtualenvs
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE="$HOME/.cache/pip"
export NVM_DIR="$HOME/.nvm"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export PRE_CXX=ccache

if which go &>/dev/null; then
    # shellcheck disable=SC2155
    export GOPATH=$(go env GOPATH)
    export PATH="$PATH:$GOPATH/bin"
fi

# }}}

# Aliases {{{

# system {{{
alias sudo="sudo " # allow $ sudo <alias>
alias v=vim
alias vi=vim
alias vitl="vim +TL"
alias pip="python -m pip"
alias p=pyeval
alias g=git
alias gg="git grep"
alias gs="git s"  # to avoid launching `ghostscript`...
alias d=dot
alias dsync=dot-sync
alias x=xargs
alias xg="xargs git"
alias pwd="pwd -P"
alias tree="tree -a -I '.git|__pycache__|*.pyc|.mypy_cache|.nox|*.egg-info|.pytest_cache|*.o|CMakeFiles|node_modules|venv|.tox|.eggs|build|dist|__reflection_metadata__.py'"
alias grep="grep --color=auto --devices=skip -I"
alias hl=highlight
if which hub &>/dev/null; then
    alias git=hub
fi
alias wt=__wt_main
alias less="less -R"
alias lsports="netstat -talpn"
alias open=xdg-open
alias o=xdg-open
alias gcd=git-cd
# }}}

# bash rc files {{{
alias bashrc="vim $HOME/.bashrc && . $HOME/.bashrc"
alias bashrclocal="vim $HOME/.bashrc.local && . $HOME/.bashrc"
alias bashrcmacos="vim $HOME/.bashrc.macos && . $HOME/.bashrc"
alias bashrclinux="vim $HOME/.bashrc.linux && . $HOME/.bashrc"
# }}}

# other rc files {{{
alias bashprofile="vim $HOME/.bash_profile"
alias bashlogout="vim $HOME/.bash_logout"
alias vimrc="vim $HOME/.vimrc"
alias vimrclocal="vim $HOME/.vimrc.local"
alias sshconf="vim $HOME/.ssh/config"
alias gitconf="vim $HOME/.gitconfig"
alias inputrc="vim $HOME/.inputrc"
alias xinitrc="vim $HOME/.xinitrc"
alias mypyrc="vim $HOME/.mypy.ini"
alias flake8rc="vim $HOME/.flake8"
# }}}

# one-liners {{{
alias peek='tee >(cat 1>&2)' # mirror stdout to stderr (for seeing data thru pipe)
alias ipaddr="curl https://api.ipify.org/"
alias weather="curl https://wttr.in"
alias late="curl https://cheat.sh/latencies"
alias t0="tmux attach -t0"
alias root='cd "$(git root | peek)"'
# }}}

# completions for aliases {{{
source /usr/share/bash-completion/completions/git
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main d
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main dot
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
# }}}

# }}}

# Functions {{{

# see where python is importing a module from
pywhich() {
    for module in "$@"; do
        python -c "import $module; print($module.__file__)";
    done
}

pywhich3() {
    for module in "$@"; do
        python3 -c "import $module; print($module.__file__)";
    done
}

# pip without a venv
gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

git-find() {
    git ls-files "$(git root)" | grep "$@"
}

git-cd() {
    dir="$1"
    shift
    cd "$(git root)/$dir" "$@"
}

# host a text file
0x0st() {
    local f
    if [[ $# -eq 0 ]]; then
        f="-"
    elif [[ $# -eq 1 ]]; then
        f="$1"
    else
        echo "Too many arguments!" >&2
        return 1
    fi
    curl -F"file=@$f" http://0x0.st
}

# interact with DOTFILES repo from anywhere
dot() {
    pushd "$DOTFILES_DIR" >/dev/null || return 1
    git "$@"
    popd >/dev/null || return 1
}

# get list of all mac-generated files
find-mac-files() {
    find "$@" -type f \( -name '._*' -or -name .DS_Store \)
}

# interactively check spelling
spellcheck() {
    f=$(mktemp)
    echo "Words to spellcheck (^D to end):" >&2
    cat >> "$f"
    aspell check "$f"
    echo && echo "Spellchecked words:" >&2
    tail -n+1 "$f"
}

# use bin/mark to change directory
mg() {
    if [[ $# -eq 0 ]]; then
        mark get
    elif [[ $# -eq 1 ]]; then
        local dest
        dest="$(mark get "$1")"
        if [[ "$dest" != null ]]; then
            cd "$dest" || return
        else
            echo "mark not set: \"$1\"" >&2
        fi
    else
        mark --help
    fi
}

ms() {
    if [[ $# -eq 0 ]]; then
        mark set
    else
        mark set "$@"
    fi
}

pycheck() {
    black "$1" \
        && mypy --strict --show-error-codes "$1" \
        && flake8 "$1"
}

# taken from https://wiki.archlinux.org/index.php/Color_output_in_console#man
man() {
    LESS_TERMCAP_md=$'\e[01;35m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

freshvenv() {
    _freshvenv "$@"
    venv="$(cat /tmp/latest-venv)"
    source "$venv/bin/activate"
}

tmpdir() {
    local tmpdir="$(mktemp --directory)"
    cd "$tmpdir"
}

to-width() {
    # Truncate stdin to fit screen
    while read -r line; do
        echo "$line" | cut -b 1-$COLUMNS;
    done
}

udiff() {
    # Generate a unified + colored diff
    diff -u "$@" | colordiff
}

ggr() {
    # git grep from repo root
    git grep "$@" -- "$(git dir)"
}

# }}}

# Misc {{{

# read the inputrc file if it exists
[[ $- == *i* ]] && [ -r "$HOME/.inputrc" ] && bind -f "$HOME/.inputrc"

# }}}
