Docker registry con SSL
---

En este docker-compose usamos 3 contenedores, el registro, un nginx proxy y un companion para descargar los certificados TLS desde let's encrypt.

Estamos usando estos contenedores porque la version nativa para descargar certificados con el mismo registry [no funciona](https://github.com/docker/distribution/issues/2545).

## Cómo usar este compose

Simplemente descargá este `docker-compose.yaml` y reemplazá estas vars:

```
# registry
VIRTUAL_HOST: docker.peladonerd.com
LETSENCRYPT_HOST: docker.peladonerd.com
LETSENCRYPT_EMAIL: pablo@peladonerd.com
```

Usando tu dominio y cuenta de correo para descargar los certs (la cuenta de correo es requerida por let's encrypt)

Luego de cambiar estas vars, simplemente levantá todo:

`docker-compose up -d`

## Cómo crear un usuario nuevo

`docker run --entrypoint htpasswd registry:2 -Bbn user pass >> auth/htpasswdp`
