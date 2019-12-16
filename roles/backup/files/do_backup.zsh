#!/usr/bin/zsh

set -e

source ~/.zshrc

export RESTIC_TAG="systemd-timer"

restic-backup
