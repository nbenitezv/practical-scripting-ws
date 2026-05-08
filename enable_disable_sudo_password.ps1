#!/bin/bash

# Function to enable or disable sudo without a password
configure_sudo_nopasswd() {
    local user=$1
    local action=$2

    if [ "$action" == "enable" ]; then
        echo "Enabling sudo without a password for user: $user"
        sudo bash -c "echo '$user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
        echo "Configuration applied: $user can now use sudo without a password."
    elif [ "$action" == "disable" ]; then
        echo "Disabling sudo without a password for user: $user"
        sudo sed -i "/$user ALL=(ALL) NOPASSWD:ALL/d" /etc/sudoers
        echo "Configuration applied: $user now requires a password to use sudo."
    else
        echo "Invalid action specified. Use 'enable' or 'disable'."
    fi
}

# Execute the configuration
configure_sudo_nopasswd "username" "disable"