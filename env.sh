export TMP=/tmp
export PATH="$HOME/.dotfiles/bin:$PATH"

alias ls='ls --color -Flh'
alias make='make -j4'
alias gvim='gvim --sync'

command_exists () {
    type "$1" &> /dev/null ;
}

PREFIX="${PREFIX:-/usr/local}"

if [ -d $PREFIX/share/chruby/ ]; then
	source $PREFIX/share/chruby/chruby.sh
	source $PREFIX/share/chruby/auto.sh
	chruby 2.3.1
fi

if [ -d $HOME/.nodenv/ ]; then
	export PATH="$HOME/.nodenv/bin:$PATH"
	eval "$(nodenv init -)"
fi

if [ -d $PREFIX/go/ ]; then
    export GOPATH="$HOME/src/gopath"
    export PATH="$GOPATH/bin:$PREFIX/go/bin:$PATH"
fi

if [ -n "$DISPLAY" ]; then
    xset -b
fi

if command_exists most; then
    export MANPAGER="$(which most)"
    alias less='most'
fi

fzf_path="$HOME/.dotfiles/.vim/plugged/fzf"
if [ -d "$fzf_path" ]; then
    export FZF_TMUX=0
    export PATH="$fzf_path/bin:$PATH"
    [[ $- == *i* ]] && source "$fzf_path/shell/completion.bash" 2> /dev/null
    source "$fzf_path/shell/key-bindings.bash"
fi
