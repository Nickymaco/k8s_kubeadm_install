#!/bin/bash
set -ex

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce-18.09.7 docker-ce-cli-18.09.7 containerd.io-1.2.6

# special docker-ce version
#sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io

sudo systemctl enable --now docker


su -c 'cat > /etc/docker/daemon.json << EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ],
  "registry-mirrors": ["https://i3xju0f4.mirror.aliyuncs.com"]
}
EOF'

sudo systemctl daemon-reload
sudo systemctl restart docker

sudo usermod -aG docker $USER

case $1 in
  master) sh k8s-master-docker-pull.sh ;;
  slave) sh k8s-slave-docker-pull.sh ;;
esac
