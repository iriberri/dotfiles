export TMP=/tmp
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

alias ls='ls --color=auto -F'
alias make='make -j4'
alias gvim='gvim --sync'
alias vim='nvim'

PREFIX="${PREFIX:-/usr/local}"

if [[ -d $PREFIX/share/chruby/ ]]; then
	source $PREFIX/share/chruby/chruby.sh
	source $PREFIX/share/chruby/auto.sh
	chruby 2.1.8
fi

if [[ -d $HOME/.nodenv/ ]]; then
	export PATH="$HOME/.nodenv/bin:$PATH"
	eval "$(nodenv init -)"
fi

if [[ -d $PREFIX/go/ ]]; then
    export GOPATH="$HOME/src/gopath"
    export PATH="$GOPATH/bin:$PREFIX/go/bin:$PATH"
fi

if [ -n "$DISPLAY" ]; then
    xset -b
fi
