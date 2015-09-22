#!/bin/sh

dev="$1"

mnt="/mnt"

vmcore="/proc/vmcore"
out="$mnt/vmcore-$(date +%F_%H-%M-%S).lz4"

mkdir -p "$mnt" && \
    mount "$dev" "$mnt" && \
    pv "$vmcore" | lz4 -6 | dd bs=4K of="$out" && \
    umount "$mnt" && \
    echo " * Core dump $out done, you can reboot now." && \
    printf '\a' > /dev/tty0
