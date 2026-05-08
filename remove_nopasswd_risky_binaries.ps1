#!/bin/bash
# --------------------------------------
# Sudo Permission Hardening Script (Simplified for /etc/sudoers)
# --------------------------------------

# List of potentially risky binaries
binarylist='cp|nmap|perl|awk|find|bash|sh|man|more|less|vi|emacs|vim|nc|netcat|python|python3|ruby|lua|irb|tar|zip|gdb|pico|scp|git|rvim|script|ash|csh|curl|dash|ed|env|expect|ftp|sftp|node|php|rpm|rpmquery|socat|strace|taskset|tclsh|telnet|tftp|wget|wish|zsh|ssh|grep|csplit|csvtool'

# Backup the original sudoers file
sudo cp /etc/sudoers /etc/sudoers.bak
echo "Backup of /etc/sudoers created at /etc/sudoers.bak"

# Iterate over risky binaries and remove NOPASSWD permissions
for binary in $(echo "$binarylist" | tr '|' ' '); do
  if sudo grep -q "NOPASSWD:.*$binary" /etc/sudoers; then
    echo "[+] Hardening sudo permission for risky binary: $binary"
    sudo sed -i "/NOPASSWD:.*$binary/d" /etc/sudoers || \
    echo "Failed to remove NOPASSWD for $binary. Manual review required."
  fi
done

# Validate the sudoers file syntax
sudo visudo -c
if [ $? -eq 0 ]; then
  echo "Sudoers file successfully hardened and syntax is valid."
else
  echo "Error: Sudoers file syntax is invalid. Reverting to backup."
  sudo cp /etc/sudoers.bak /etc/sudoers
fi