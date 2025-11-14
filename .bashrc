PS1=$PS1'\e[1 q'
HISTSIZE=200
HISTCONTROL=ignoredups

#PATH=$PATH:.
CDPATH=~/works/data:~/works/repo:~/works/opt

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

export VISUAL=vim
export EDITOR=$VISUAL

alias ll='ls -lah'
alias ltr='ls -ltrh'
alias rm="rm -I"
alias free="free -m"
alias df="df -h"
alias d=dirs
alias gd=pushd
alias pd=popd
alias h='history | tac'
alias c=clear

alias gw=gradlew
alias mw=mvnw

# https://superuser.com/questions/240180/creating-an-alias-containing-bash-history-expansion
alias sudothat='eval "sudo $(fc -ln -1)"'

# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# https://unix.stackexchange.com/questions/20396/make-cd-automatically-ls
cdls() { cd "$@" && ls -a; }

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
