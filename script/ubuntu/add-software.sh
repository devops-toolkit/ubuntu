#!/bin/bash -eux

echo "==> Make this box suitable for ansible provisioning"
apt-get update
apt-get install -y python python-apt
