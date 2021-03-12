#!/bin/bash
kubectl get all,configmaps -l sparkfabrik.com/game=${1}
