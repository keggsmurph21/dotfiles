# add default options to sh cmds
alias ls='ls --color=auto'
alias ls="ls -aF --color=auto"

# source sh rc changer
alias shrc="vim $HOME/.shrc && source $HOME/.bashrc && source $HOME/.zshrc"
alias bashrc="vim $HOME/.bashrc && source $HOME/.bashrc"
alias zshrc="vim $HOME/.zshrc && source $HOME/.zshrc"
alias vimrc="vim /usr/local/etc/vimrc"
alias aliasrc="vim /usr/local/etc/aliases.sh && source /usr/local/etc/aliases.sh"

# override defaults
alias vi=vim
alias python="python3"

# git stuff
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gau="git add -u"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gb="git checkout -b"
alias gbl="git branch --list"
alias gp="git push"
alias gd="git diff -w"

# other stuff
alias xdim="redshift -l 39.95233:-75.16379"
alias xcopy="xclip -i -selection c"
alias xpaste="xclip -o -selection c"
alias ssh-lab="ssh kmurphy4@lab.cs.swarthmore.edu"
alias screenshot="maim -s ~/screenshots/$(date +%s).png"
