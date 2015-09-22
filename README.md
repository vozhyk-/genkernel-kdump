genkernel-kdump
===============

Scripts for creating a simple initramfs for vmcore dumps (using `genkernel`)

Usage
-----
Look into `config.sh` and change the options to your liking.
Replace `your_kernel_version` with e.g. `4.0.9-aufs`.
```
# ./make-initramfs.sh your_kernel_version
```
Configure kexec to use the new initramfs


When the kernel crashes and kexecs into the new initramfs,
type `shell` when prompted for the root device.

Determine which filesystem you want to dump `/proc/vmcore` to
```
# blkid
```

Pass its device to the script, can be anything mount accepts.
```
# dump-core.sh LABEL=SYSRESC
```

Reboot with Control-Alt-Del
```

Installation
------------
Copy/link `make-initramfs.sh` to a directory in your PATH.
