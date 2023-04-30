#
# .profile
#
#export EDITOR='emacs -nw'
export EDITOR=vim
export VISUAL=emacs
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
export PATH="$HOME/.local/bin:/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
export ENV=~/.shrc
