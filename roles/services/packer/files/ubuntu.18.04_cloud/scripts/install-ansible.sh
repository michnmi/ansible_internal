#!/bin/bash

set -e -x

# Following the official ansible docs: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu

# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
echo 'Installing Ansible on host'
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

ansible -v
