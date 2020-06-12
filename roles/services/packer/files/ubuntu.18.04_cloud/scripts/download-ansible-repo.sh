#!/bin/bash

set -e -x

echo 'Get git and ansible codebase on the host.'
# sudo apt-get update -y
sudo apt-get install -y git

cd /tmp/
git clone https://github.com/michnmi/ansible_internal

cd ansible_internal
ansible-playbook  -i 'localhost' -l localhost playbooks/common.yml
id michnmi