#!/bin/bash

exists()
{
  command -v "$1" >/dev/null 2>&1
}

mydir=${0%/*}

if exists betterlockscreen; then
    betterlockscreen  \
        --update "$mydir/wallpaper.png" \
        --resolution 1920x1080
fi
