#!/bin/zsh

if $(which ntfy > /dev/null); then
    eval "$(ntfy shell-integration --longer-than 20 --shell zsh)"
    # extra ignored ntfy commands
    export AUTO_NTFY_DONE_IGNORE="$AUTO_NTFY_DONE_IGNORE irc dmesg bat journalctl"
fi
