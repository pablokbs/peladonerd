#!/bin/bash
set -e
killall -9 kubectl || true
kubectl port-forward svc/${1} 8080:8080 8081:8081 &
xdg-open http://localhost:8080
