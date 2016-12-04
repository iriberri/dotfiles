#!/bin/bash

set -e
DOTFILES=$( cd $(dirname $0) ; pwd -P )

symlink() {
    local source="$DOTFILES/$1"
    local dest="$HOME/$1"

    if [ -L "$dest" ]; then
        echo "[EXISTS] ${dest}"
        return
    fi

    if [ -f "$dest" ]; then
        echo "[BACKUP] ${dest} => ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
        
    echo "[LINK] $source => $dest"
    ln -s "$source" "$dest"
}

github-raw() {
    curl -fL "https://raw.githubusercontent.com/$1/$2/$3" 
}

# Shells
symlink .bashrc
symlink .zshrc

# Tools
symlink .gitconfig
symlink .tmux.conf
symlink .fonts

# Vim
symlink .vim

if [ ! -L "$HOME/.config/nvim" ]; then
    ln -sf $DOTFILES/.vim $HOME/.config/nvim
fi
