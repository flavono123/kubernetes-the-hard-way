#!/bin/bash

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
cat <<EOF > values.yaml
nfs:
  path: /nfs-storage
  server: 192.168.1.2
  nodeSelector:
  kubernetes.io/hostname: cluster1-master1
tolerations:
- key: node-role.kubernetes.io/master
  operator: Exists
  effect: NoSchedule
EOF

k create ns nfs-provisioner
helm install nfs-provisioner -n nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --values values.yaml
