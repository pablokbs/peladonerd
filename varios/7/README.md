## Comandos Podman

Correr un container

`podman run -it alpine sh`

Construir una imagen

```Containerfile
FROM alpine
RUN echo "Hola desde podman"
```

`podman build -t prueba:latest .`

Ver imagenes

`podman images`

Correr Pods en Podman

`podman pod create --name wordpress_full -p 8080:80`

Agregar contenedores al pod

```
podman run -d --pod wordpress_full \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_ROOT_PASSWORD=root \
  mysql:5.7 \
  --default-authentication-plugin=mysql_native_password

```

```
podman run -d --pod wordpress_full \
  -e WORDPRESS_DB_USER=root \
  -e WORDPRESS_DB_PASSWORD=root \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_DB_HOST=127.0.0.1 \
  wordpress:5.4.2-php7.2-apache
```

Ver procesos en el pod

`podman top pod wordpress_full`

Generar manifiestos Kubernetes o SystemD

`podman generate --help`

`podman generate kube wordpress_full > wordpress_full.yaml`

Instalar podman-compose

```
sudo curl -o /usr/local/bin/podman-compose https://raw.githubusercontent.com/containers/podman-compose/devel/podman_compose.py
sudo chmod +x /usr/local/bin/podman-compose
```

`podman-compose up -d`
