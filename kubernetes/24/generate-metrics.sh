#!/bin/bash

cluster=$1
replica=$2
retention=$3

# Add volume and generated metrics inside it.
#kubectl apply --context=${cluster} -f manifests/prometheus-pv-${replica}.yaml
rm -rf -- /tmp/prom-out
mkdir /tmp/prom-out
go run ./blockgen/main.go --input=./blockgen/container_mem_metrics_${cluster}.json --output-dir=/tmp/prom-out --extra-labels="cluster=${cluster}" --retention=${retention}
chmod -R 775 /tmp/prom-out
# Fun with permissions because Prometheus process is run a "noone" in a pod... ):
#minikube -p ${cluster} ssh "sudo rm -rf /data/pv-prometheus-${replica} && sudo mkdir -p /data/pv-prometheus-${replica} && sudo chmod -R 777 /data/pv-prometheus-${replica}"
#scp -r -i $(minikube -p ${cluster} ssh-key) /tmp/prom-out/* docker@$(minikube -p ${cluster} ip):/data/pv-prometheus-${replica}/
kubectl --context=${cluster} -n monitoring exec -t prometheus-k8s-${replica} -c prometheus -- rm -rf /prometheus/wal/*
kubectl --context=${cluster} -n monitoring cp /tmp/prom-out/* prometheus-k8s-${replica}:/prometheus/ -c prometheus
kubectl --context=${cluster} -n monitoring exec -t prometheus-k8s-${replica} -c prometheus -- kill -HUP 1

#minikube -p ${cluster} ssh "sudo chmod -R 777 /data/pv-prometheus-${replica}"