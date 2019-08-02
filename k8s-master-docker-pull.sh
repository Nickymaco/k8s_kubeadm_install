#!/bin/bash
set -ex

registry=registry.cn-hangzhou.aliyuncs.com/google_containers
k8stag=k8s.gcr.io
images=(
kube-apiserver:v1.14.3
kube-controller-manager:v1.14.3
kube-scheduler:v1.14.3
kube-proxy:v1.14.3
pause:3.1
coredns:1.3.1
)

for i in ${images[*]}; do
  docker pull $registry/$i
  docker tag $registry/$i $k8stag/$i
done

docker pull quay.io/coreos/etcd:v3.3.10
docker tag quay.io/coreos/etcd:v3.3.10 $k8stag/etcd:v3.3.10


docker pull quay.io/coreos/flannel:v0.11.0
