PREFIX="${PREFIX:-/usr/local}"

export TMP=/tmp
export PATH="$HOME/.dotfiles/bin:$PREFIX/bin:$PATH"

alias make='make -j4'
alias gvim='gvim --sync'

command_exists () {
    type "$1" &> /dev/null ;
}

if [ -d $PREFIX/share/chruby/ ]; then
	source $PREFIX/share/chruby/chruby.sh
	source $PREFIX/share/chruby/auto.sh
	chruby 2.3.3
fi

if [ -d $HOME/.nodenv/ ]; then
	export PATH="$HOME/.nodenv/bin:$PATH"
	eval "$(nodenv init -)"
fi

if [ -d $PREFIX/go/ ]; then
    export PATH="$PREFIX/go/bin:$PATH"
fi

if command_exists go; then
    export GOPATH="$HOME/src/gopath"
    export PATH="$GOPATH/bin:$PATH"
fi

fzf_path="$HOME/.dotfiles/.vim/plugged/fzf"
if [ -d "$fzf_path" ]; then
    export FZF_TMUX=0
    export PATH="$fzf_path/bin:$PATH"
    sh="$(basename $SHELL)"
    [[ $- == *i* ]] && source "$fzf_path/shell/completion.$sh" 2> /dev/null
    source "$fzf_path/shell/key-bindings.$sh"
fi
