#!/bin/bash

echo "get token"
token=$(kubeadm token create)

echo "get token hash"
ca=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')

echo -e "you should be exec on node like this: \n kubeadm join $(hostname -i):6443 --token $token \\ \n --discovery-token-ca-cert-hash sha256:"$ca
