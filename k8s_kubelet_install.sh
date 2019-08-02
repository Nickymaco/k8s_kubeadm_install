#!/bin/bash
set -ex

su -c 'cat << EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF'

sudo yum install -y kubelet-1.14.3 kubeadm-1.14.3 kubectl-1.14.3 --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

su -c 'cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_nonlocal_bind = 1
net.ipv4.ip_forward = 1
vm.swappiness = 0
EOF'

sudo modprobe br_netfilter

sudo systemctl daemon-reload
sudo systemctl restart kubelet
