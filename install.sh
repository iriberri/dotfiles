#!/bin/bash

set -e

DOTFILES=$( cd $(dirname $0) ; pwd -P )
fzf_version=0.13.4

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
symlink .zshenv

# Tools
symlink .gitconfig
symlink .tmux.conf
symlink .fonts

# Vim
symlink .vim

# fzf and tools
fzf_bin="fzf-$fzf_version-linux_amd64"
fzf_url="https://github.com/junegunn/fzf-bin/releases/download/$fzf_version/${fzf_bin}.tgz"
curl -fL "$fzf_url" | tar -C "$DOTFILES/bin" -xz
ln -s "$DOTFILES/bin/$fzf_bin" "$DOTFILES/bin/fzf"

mkdir -p "$DOTFILES/fzf"
github-raw junegunn/fzf $fzf_version shell/completion.bash > "$DOTFILES/fzf/completion.bash"
github-raw junegunn/fzf $fzf_version shell/key-bindings.bash > "$DOTFILES/fzf/key-bindings.bash"
