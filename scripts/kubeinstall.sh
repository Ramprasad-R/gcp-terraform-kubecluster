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
   
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
   
sleep 60
   
sudo mkdir -p /home/ubuntu/.kube
   
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
   
sudo chown ubuntu:ubuntu -R /home/ubuntu/
 
sleep 60
 
export KUBECONFIG=/home/ubuntu/.kube/config && kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
 
echo 'source <(kubectl completion bash)' >>  /home/ubuntu/.bashrc
 
# Allow workloads to be scheduled to the master node
kubectl taint nodes `hostname`  node-role.kubernetes.io/master:NoSchedule-

TOKEN=`kubeadm token generate`

kubeadm token create  $TOKEN --print-join-command > /tmp/kube_join.sh