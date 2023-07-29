#
# ~/.bashrc
#

# If not running interactively, don't do anything

#
[[ $- != *i* ]] && return


source ~/.shrc
source ~/.alias
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

# adds bash completion for aliases requires bash-complete-alias
# shellcheck disable=SC1091
[ -f  /usr/share/bash-complete-alias/complete_alias ] \
        && . /usr/share/bash-complete-alias/complete_alias; \
        complete -F _complete_alias config

eval $(pandoc --bash-completion)


PATH="/home/m/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/m/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/m/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/m/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/m/perl5"; export PERL_MM_OPT;

# needed for autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
