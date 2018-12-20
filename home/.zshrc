# The following lines were added by compinstall

if [ ! -z $ZSH_NAME ]; then

    zstyle ':completion:*' completer _expand _complete _ignored
    zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}'
    zstyle :compinstall filename '/home/kilgore/.zshrc'

    autoload -Uz compinit
    compinit
    # End of lines added by compinstall
    # Lines configured by zsh-newuser-install
    HISTFILE=~/.zsh_history
    HISTSIZE=1000
    SAVEHIST=1000
    bindkey -e
    # End of lines configured by zsh-newuser-install


    # custom set options
    setopt sh_word_split

    # source external stuff
    source ~/.shrc

    # prompts
    PS1='\e[01m\e[92m%n@%m\e[0m:\e[94m%~ \e[0m%# '
    PS1='%F{green}%n@%m%f:%F{blue}%~ %f%# '
    PS1=$'%{\e[1;92m%}%n@%m%{\e[0m%}:%{\e[94m%}%~ %{\e[0m%}%# '
    function zle-line-init zle-keymap-select {
        RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/}"
        RPS2=$RPS1
        zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select

    # fix keyboard mapping things
    source $HOME/.zkbd/default-keymappings
    [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
    [[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
    [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
    [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line

fi
