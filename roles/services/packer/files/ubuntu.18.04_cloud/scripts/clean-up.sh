#!/bin/bash

set -e -x

echo "Reset cloud-init."
cloud-init clean --logs
