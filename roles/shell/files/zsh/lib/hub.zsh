#!/bin/zsh

if which hub > /dev/null 2>&1 ; then
    eval $(hub alias -s);
fi
