#!/bin/bash
# Script that imports a IP subnet list to the BLOCK_NET IPset table
# Typically import the Firehol level1 list
# Authored and maintained by Trent Paris

while read -r ip; do
    # Skip lines starting with #
    if [[ $ip =~ ^# ]]; then
        echo "Skipping comment line: $ip"
        continue
    fi

    # Skip RFC1918 addresses
    if [[ $ip =~ ^10\..* ]] || [[ $ip =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\..* ]] || [[ $ip =~ ^192\.168\..* ]]; then
        echo "Skipping private IP address: $ip"
        continue
    fi

    # Add IP to ipset list
    sudo ipset add BLOCK_NET "$ip"
done < firehol_level1.netstat
