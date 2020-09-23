#!/bin/zsh

headphones() {
    bluetoothctl connect CC:98:8B:3D:E8:18
}

disconnect() {
    bluetoothctl disconnect CC:98:8B:3D:E8:18
}
