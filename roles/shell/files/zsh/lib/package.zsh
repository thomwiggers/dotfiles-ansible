#!/bin/zsh

package() {
    tar cvJf "$1.tar.xz" "$*"
}
