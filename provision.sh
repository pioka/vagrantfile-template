#!/bin/sh
set -x
## This is an example. Write your provisioning script here.
#
#mkdir -p /etc/apt/keyrings
##================================
## Install docker
##================================
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
#echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
#  > /etc/apt/sources.list.d/docker.list
#apt-get update && apt-get install -y docker-ce
#
##================================
## Install nomad
##================================
#curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --yes --dearmor -o /etc/apt/keyrings/hashicorp.gpg
#echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
#  > /etc/apt/sources.list.d/hashicorp.list
#apt-get update && apt-get install -y nomad
#
##================================
## Install cni-plugin
##================================
#mkdir -p /opt/cni/bin
#curl -fsSL "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-amd64-v1.0.0.tgz" | tar -xz -C /opt/cni/bin
