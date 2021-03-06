function restic-backup {
    source "$HOME/.local/lib/restic_settings.zsh"
    restic \
        --option b2.connections=10 \
        backup $HOME \
        --tag "${RESTIC_TAG:-manual}" \
        --one-file-system \
        --exclude "*.o" \
        --exclude "*.a" \
        --exclude "*.pyc" \
        --exclude "*.sage.py" \
        --exclude "/home/thom/Downloads" \
        --exclude "/home/thom/VirtualBox VMs" \
        --exclude "/home/thom/Arduino" \
        --exclude "/home/thom/bin" \
        --exclude "/home/thom/Nextcloud" \
        --exclude "/home/thom/Videos" \
        --exclude "/home/thom/.*" \
        "/home/thom/.gnupg" \
        "/home/thom/.ssh" \
        "/home/thom/.password-store" \
        "/home/thom/.config" \
        --exclude "/home/thom/.config/google-chrome" \
        --exclude "/home/thom/.config/chromium" \
        --exclude "/home/thom/.config/Code" \
        --exclude "/home/thom/.config/skypeforlinux" \
        --exclude-if-present ".rustc_info.json" \
        --exclude-if-present ".restic-ignore" \
        --exclude-caches \
        $@

    restic \
        --option b2.connections=10 \
        forget \
        --keep-monthly 6 \
        --keep-weekly 4 \
        --keep-daily 7 \
        --prune

    restic check
}

function restic-unlock {
    source "$HOME/.local/lib/restic_settings.zsh"
    restic unlock
}
