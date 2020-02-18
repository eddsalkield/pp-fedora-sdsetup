#!/bin/bash
set -e

echo "================"
echo "04-edit-fstab.sh"
echo "================"

# Functions
infecho () {
    echo "[Info] $1"
}

# Notify User
infecho "The env vars that will be used in this script..."
infecho "PP_PARTB = $PP_PARTB"
echo

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Mounting root file system..."
    mkdir -p rootfs
    mount $PP_PARTB rootfs

    infecho "Fixing /etc/fstab..."
    # TODO: Edit the /etc/fstab with the proper entries.

    infecho "Unmounting root file system..."
    umount $PP_PARTB
    rmdir rootfs
fi