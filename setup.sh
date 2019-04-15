#!/usr/bin/env bash

# Crash and burn if not in repo directory
[ ! -s setup.sh ] && exit 1

git submodule init
git submodule update --depth 1

repo=${PWD##$HOME/}

for f in .vim .vimrc .profile .gitconfig .inputrc .gitignore-global .spacemacs
do
    dest=~/$f
    src=$repo/$f
    [ ! -e $dest ] && ln -s $src $dest 2>/dev/null
done

brew install fzf ripgrep thefuck bash-completion emacs-plus git htop leiningen httpie jrnl pyenv python3

