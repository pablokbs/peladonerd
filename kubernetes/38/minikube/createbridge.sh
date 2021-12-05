#!/bin/bash

VBoxManage controlvm minikube poweroff

opts=""
nic=$( VBoxManage showvminfo minikube --machinereadable | grep ^nic | grep '"none"' | head -n1 | cut -d= -f1 | cut -c4- )
int=$( route get google.com | grep interface: | awk '{ print $2 }' )

if [ -n "${MINIKUBE_NIC_BRIDGED_MAC:-}" ]; then
  opts="--macaddress$nic $MINIKUBE_NIC_BRIDGED_MAC"
fi

VBoxManage modifyvm minikube --nic$nic bridged --bridgeadapter$nic $int $opts
