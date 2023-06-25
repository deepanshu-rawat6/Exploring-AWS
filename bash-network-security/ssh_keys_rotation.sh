#!/bin/bash

if [ -z "$1" ]; then
        echo "Please provide IP address"
        exit 1
fi

private_instance_ip="$1"
user="ubuntu"

# Generating the new key
ssh-keygen -t rsa -f new_key_temp -N ""

# Copy the newly generated key to the private instance
scp -i ./new_key ./new_key_temp.pub "$user@$private_instance_ip":~

# Adding the new_key.pub to the authorized keys of private instance
ssh -i ./new_key "$user@$private_instance_ip" "cp -f ~/new_key_temp.pub ~/.ssh/authorized_keys"

# temp key to new key
cp -f ./new_key_temp ./new_key
cp -f ./new_key_temp.pub ./new_key.pub

# To see if the new key works
ssh -i ./new_key "$user@$private_instance_ip"