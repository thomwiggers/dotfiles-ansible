#!/bin/zsh

open() {
    xdg-open $@ 2> /dev/null & disown
}
