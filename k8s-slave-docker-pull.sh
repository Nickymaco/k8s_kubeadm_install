#!/bin/bash
registry=registry.cn-hangzhou.aliyuncs.com/google_containers
k8stag=k8s.gcr.io
images=(
kube-proxy:v1.14.3
pause:3.1
)

for i in ${images[*]}; do
  sudo docker pull $registry/$i
  sudo docker tag $registry/$i $k8stag/$i
done

sudo docker pull quay.io/coreos/flannel:v0.11.0
