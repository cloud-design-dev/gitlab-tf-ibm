#!/usr/bin/env bash

# Author: Ryan Tiffany
# Email: rtiffany@us.ibm.com

# Script Variables
DIALOG='\033[0;36m' 
WARNING='\033[0;31m'
LINKY='\033[0;41m'
NC='\033[0m'

# Get CIS instance name
# Sed replace generic example in data.tf
echo -n -e "${DIALOG}Please supply your CIS instance name${NC}  "
read -r CIS_INSTANCE
echo -e "\n${DIALOG}Please supply your CIS domain name ${NC}  "
read -r CIS_DOMAIN 
echo -e "\n${DIALOG}Please supply a valid email address (Used for SSL renewal communication) ${NC}  "
read -r EMAIL_ADDR 
echo -e "\n${DIALOG}Please supply your local machines public SSH key (cat ~/.ssh/id_rsa.pub in most cases) ${NC}  "
read -r SSH_KEY



# Get CIS instance domain 
# Sed replace generic example in data.tf
# Sed replace example in variables.tf

# Get email address 
# Sed replace example in variables.tf


# Set ssh private key 
# ssh-rsa-example-key