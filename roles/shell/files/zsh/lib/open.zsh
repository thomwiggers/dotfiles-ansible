#!/bin/zsh

open() {
    for f in $@; do
        if ! [ -f "$f" ]; then
            echo "No such file $f"
        else
            xdg-open $f 2> /dev/null &!
        fi
    done
}
