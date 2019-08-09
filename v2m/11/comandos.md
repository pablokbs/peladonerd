1. Kubectl Autocomplete

```
# bash
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
alias k=kubectl
complete -F __start_kubectl k

# zsh
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell

## kubectl get ns <tab>
```

2. Kubectl delete from file

```
kubectl apply -f manifest.yaml
kubectl delete -f manifest.yaml
```

3. Kubectl Run

```
kubectl run -it alpine --image=alpine -- sh
```

4. Get pods con labels

```kubectl get pods -l run=nginx --all-namespaces```

5. Get pods (o cualquier cosa) diferente formato

```
kubectl get pods -o=name
kubectl get pods -o=wide
kubectl get pods -o=yaml
kubectl get pods -o=json
```

6. Get pods para hacer un manifest

```kubectl -n nginx1 get pod nginx-6fd8984946-8m648 -o yaml --export```

7. Get the version label of all pods with label app=cassandra

```
kubectl get pods -l run=nginx --all-namespaces -o \
  jsonpath='{.items[*].spec.containers[*].image}'
```

8. Estadisticas de un o varios nodos

```kubectl top node <nombre-del-nodo>```

9. Traerte el estado de los componentes 

```kubectl get componentstatuses```

10. Traerte los recursos disponibles

```kubectl api-resources```
