function restic-backup {
    source "$HOME/.local/lib/restic_settings.zsh"
    restic \
        --option b2.connections=10 \
        backup $HOME \
        --exclude "*.o" \
        --exclude "*.pyc" \
        --exclude "*.sage.py" \
        --exclude "/home/thom/Downloads" \
        --exclude "/home/thom/VirtualBox VMs" \
        --exclude "/home/thom/Arduino" \
        --exclude "/home/thom/bin" \
        --exclude "/home/thom/Nextcloud" \
        --exclude "/home/thom/Videos" \
        --exclude "/home/thom/.*" \
        --exclude-if-present ".restic-ignore" \
        --exclude-caches \
        $@

    restic \
        --option b2.connections=10 \
        backup \
        "/home/thom/.gnupg" \
        "/home/thom/.ssh" \
        "/home/thom/.password-store" \
        "/home/thom/.lastpass" \
        "/home/thom/.config" \
        --exclude "/home/thom/.config/chromium" \
        --exclude-if-present ".rustc_info.json" \
        --exclude-caches \
        $@
}