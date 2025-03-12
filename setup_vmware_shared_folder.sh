#!/bin/bash

# Define shared folder name
SHARE_NAME="vmshare"
MOUNT_POINT="/mnt/hgfs/$SHARE_NAME"

echo "[+] Updating package lists..."
sudo apt update -y

echo "[+] Installing VMware Tools (if not installed)..."
sudo apt install -y open-vm-tools open-vm-tools-desktop fuse

echo "[+] Creating mount point: $MOUNT_POINT"
sudo mkdir -p "$MOUNT_POINT"

echo "[+] Mounting the shared folder..."
sudo mount -t fuse.vmhgfs-fuse ".host:/$SHARE_NAME" "$MOUNT_POINT" -o allow_other

# Verify if the mount was successful
if mount | grep -q "$MOUNT_POINT"; then
    echo "[+] vmshare successfully mounted at $MOUNT_POINT"
else
    echo "[!] Mounting failed. Check VMware settings and try again."
    exit 1
fi

echo "[+] Adding mount to /etc/fstab for persistence..."
FSTAB_ENTRY=".host:/$SHARE_NAME $MOUNT_POINT fuse.vmhgfs-fuse allow_other 0 0"
if ! grep -q "$FSTAB_ENTRY" /etc/fstab; then
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
    echo "[+] Added to /etc/fstab."
else
    echo "[!] Entry already exists in /etc/fstab."
fi

echo "[+] Reloading fstab settings..."
sudo mount -a

echo "[+] Done! You can access your shared folder at $MOUNT_POINT"
