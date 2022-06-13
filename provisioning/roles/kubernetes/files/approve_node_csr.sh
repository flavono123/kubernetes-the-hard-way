#!/bin/bash

kubectl get csr --field-selector 'spec.signerName=kubernetes.io/kubelet-serving' -ojsonpath='{.items[*].metadata.name}' | xargs kubectl certificate approve
