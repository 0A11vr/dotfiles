#
# ~/.bashrc
#

# If not running interactively, don't do anything

#
[[ $- != *i* ]] && return


source ~/.shrc
source ~/.alias

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# adds bash completion for aliases requires bash-complete-alias
# shellcheck disable=SC1091
[ -f  /usr/share/bash-complete-alias/complete_alias ] \
        && . /usr/share/bash-complete-alias/complete_alias; \
        complete -F _complete_alias config
