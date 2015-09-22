#!/bin/bash

. /usr/share/genkernel/gen_initramfs.sh

src_dir="$(dirname "$(realpath "$0")")"

. "$src_dir"/config.sh

kernel_ver="$1"
arch="x86_64"
genkernel_img_prefix="/boot/initramfs-genkernel"
genkernel_img="$genkernel_img_prefix-$arch-$kernel_ver"
kdump_img="$genkernel_img_prefix-kdump-$arch-$kernel_ver"

copy_binaries "$work_dir" $(which $extra_binaries)
cp -p "$src_dir"/dump-core.sh "$work_dir"/bin

mv -v "$genkernel_img"{,.b-kdump} # backup normal image

genkernel --no-zfs --initramfs-overlay="$work_dir" initramfs

mv -v "$genkernel_img" "$kdump_img"
mv -v "$genkernel_img"{.b-kdump,} # restore normal image
