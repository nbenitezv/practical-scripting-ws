#!/bin/bash

user_to_remove="username_here"  # Replace "username_here" with the actual username

sudo_users=$(getent group sudo | cut -d":" -f4)

if [[ "$sudo_users" == *"$user_to_remove"* ]]; then
  echo "[+] User $user_to_remove found in the sudo group."
  
  sudo deluser "$user_to_remove" sudo
  echo "[-] User $user_to_remove removed from the sudo group."
else
  echo "[-] User $user_to_remove is not in the sudo group or does not exist."
fi