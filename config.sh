#!/bin/bash

# Directory where the scripts and binaries are copied to
work_dir="/usr/src/initramfs-kdump"

# Extra binaries you might want to include in the initramfs
# pv, lz4 and date are required for dump-core.sh
extra_binaries="pv lz4 date"
