#!/bin/bash

mydir=${0%/*}

if [ "$1" = "--suspend" ]; then
    suspend=1
fi

suspend() {
    if [ $suspend ]; then
        sleep 2;
        systemctl suspend
    fi
}

exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists betterlockscreen; then
    if [ $suspend ]; then
        betterlockscreen --suspend
    else
        betterlockscreen --lock
    fi
elif exists i3lock-fancy; then
    i3lock-fancy --greyscale --pixelate -- scrot --silent --multidisp
    suspend
else
    i3lock --image="$mydir/wallpaper.png" \
        --ignore-empty-password \
        --show-failed-attempts \
        --tiling
    suspend
fi
