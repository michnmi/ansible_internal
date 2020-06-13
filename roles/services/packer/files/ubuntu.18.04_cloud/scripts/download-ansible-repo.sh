#!/bin/bash

set -e -x

echo 'Get git and ansible codebase on the host.'
# sudo apt-get update -y
sudo apt-get install -y git

cd /tmp/
git clone https://github.com/michnmi/ansible_internal

cd ansible_internal
git checkout --track origin/CICD-5

ps -ef | grep ubuntu
id`
# pkill -9 -U 1000

ansible-playbook  -i inventories/cloud_vms/hosts.ini -l cloud_vm playbooks/cloud_vm.yml
id michnmi
