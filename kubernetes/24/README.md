# Instalar Thanos Metrics con Prometheus Operator

### Crear 2 clusters y aplicar prometheus

```
kubectl --context cluster1 apply -f prometheus/setup
kubectl --context cluster1 apply -f prometheus/

kubectl --context cluster2 apply -f prometheus/setup
kubectl --context cluster2 apply -f prometheus/
```

### Generar secret

`vim thanos-objstore.yaml`

```
type: S3
config:
  bucket: "xxxx"
  endpoint: "s3.amazonaws.com"
  region: "us-east-1"
  access_key: "yyyy"
  secret_key: "zzzz"
```

### Encodear en base64 y generar kubernetes secret

`cat thanos-objstore.yaml | base64`

### Crear kubernetes secret

`vim thanos-objstore-secret.yaml`

```
apiVersion: v1
kind: Secret
metadata:
  name: thanos-objectstorage
  namespace: monitoring
  labels:
    app: thanos
type: Opaque
data:
  thanos.yaml: xxxxxxxxx==
```

### Aplicar secret

```
kubectl --context cluster1 apply -f thanos-objstore-secret.yaml
kubectl --context cluster2 apply -f thanos-objstore-secret.yaml
```
### Crear servicio para thanos-sidecars

```
kubectl --context=cluster1 -n monitoring apply -f 01-thanos-sidecar-svc.yaml
kubectl --context=cluster2 -n monitoring apply -f 01-thanos-sidecar-svc.yaml
```

### Instalar Thanos-store + Thanos-query

```
kubectl --context cluster1 apply -f 02-thanos-querier.yaml
```