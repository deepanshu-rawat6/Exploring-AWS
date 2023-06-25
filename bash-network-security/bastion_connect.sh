#!/bin/bash

# Checking whether the KEY_PATH env var is set
if [ -z "$KEY_PATH" ]; then
    echo "KEY_PATH env var is expected"
    exit 5
fi

# Taking arguments, in variables
public_instance_ip="$1"
private_instance_ip="$2"
command="$3"

# Checking whether the public_instance_ip is set
if [ -z "$public_instance_ip" ]; then
    echo "Please provide bastion IP address"
    exit 5
fi

# Checking whether the private_instance_ip was provided
if [ -z "$private_instance_ip" ]; then
    # This command connects to the bastion host
   	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip"

# Checking whether the command was provided
elif [ -z "$command" ]; then
    # This command connects to the private instance, with help of bastion host
    ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip"
else
    # This command connects to the private instance, with help of bastion host, and executes the command, and then exits
	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip" "$command"
fi