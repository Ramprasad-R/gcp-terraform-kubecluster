#!/bin/sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install  -y   apt-transport-https     ca-certificates     curl     software-properties-common
   
sudo apt-get install -y docker.io

sudo systemctl enable docker
   
sudo bash -c 'cat << EOF > /etc/docker/daemon.json
{
   "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF'
   
   
   
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   
sudo bash -c 'cat << EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
   
   
sudo apt update
   
sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl