#!/bin/bash

. /usr/share/genkernel/gen_initramfs.sh

src_dir="$(dirname "$(realpath "$0")")"

. "$src_dir"/config.sh

kernel_ver="$1"
arch="x86_64"
genkernel_img_prefix="/boot/initramfs-genkernel"
genkernel_img="$genkernel_img_prefix-$arch-$kernel_ver"
kdump_img="$genkernel_img_prefix-kdump-$arch-$kernel_ver"

# TODO error checking

copy_binaries "$work_dir" $(which $extra_binaries)
cp -p "$src_dir"/dump-core.sh "$work_dir"/bin

echo " * Backing up original genkernel initramfs"
mv -v "$genkernel_img"{,.b-kdump} # backup normal image

echo " * Creating initramfs"
genkernel --no-zfs --initramfs-overlay="$work_dir" initramfs

echo " * Renaming initramfs image"
mv -v "$genkernel_img" "$kdump_img"
echo " * Restoring original genkernel initramfs"
mv -v "$genkernel_img"{.b-kdump,} # restore normal image

echo " * Initramfs $kdump_img created."
