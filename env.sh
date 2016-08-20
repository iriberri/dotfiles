export TMP=/tmp
export TERM=xterm-256color
export PATH="$HOME/.dotfiles/bin:$PATH"

alias ls='ls --color=auto -F'
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

if command_exists exa; then
    alias ls='exa -l'
fi

if command_exists fzf; then
    export FZF_TMUX=0
    [[ $- == *i* ]] && source "$HOME/.dotfiles/fzf/completion.bash" 2> /dev/null
    source "$HOME/.dotfiles/fzf/key-bindings.bash"
fi
