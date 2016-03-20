#!/bin/bash

DOTFILES=$( cd $(dirname $0) ; pwd -P )

symlink() {
    local source="$DOTFILES/$1"
    local dest="$HOME/$1"

    if [ -f "$dest" ]; then
        echo "[BACKUP] ${dest} => ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
        
    echo "[LINK] $source => $dest"
    ln -s "$source" "$dest"
}

# Shells
symlink .bashrc
symlink .zshrc
symlink .zshenv

# Tools
symlink .gitconfig
symlink .tmux.conf
symlink .fonts

# Vim
symlink .vim
