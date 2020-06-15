#!/bin/bash

set -e -x

echo "Reset cloud-init."
cloud-init clean --logs

echo "Remove user no longer needed"
userdel --force packer
