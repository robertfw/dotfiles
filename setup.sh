#!/usr/bin/env bash

# Crash and burn if not in repo directory
[ ! -s setup.sh ] && exit 1

git submodule init
git submodule update --depth 1

repo=${PWD##$HOME/}

for f in .vim .vimrc .bash_profile .gitignore_global .spacemacs
do
    dest=~/$f
    src=$repo/${f#.}
    [ ! -e $dest ] && ln -s $src $dest 2>/dev/null
done

# TODO: install ripgrep, fzf
