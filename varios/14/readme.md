# Pasos para instalar Mastodon

## Antes de iniciar

* Copiar `docker-compose.yaml` y `.env.production`
* Modificar `.env.production` con valores de dominio, smtp y DB
* Correr los siguientes comandos para generar las keys: SECRET_KEY_BASE y OTP_SECRET

```
docker-compose run --rm web bundle exec rake secret # 2 veces (genera SECRET_KEY_BASE y OTP_SECRET)
docker-compose run --rm web bundle exec rake webpush:generate_keys # genera VAPID_PRIVATE_KEY y VAPID_PUBLIC_KEY
docker-compose run --rm web bundle exec rake db:migrate # genera estructura de DB
docker-compose run --rm web bundle exec rake assets:precompile # genera archivos estaticos
```

* Modificar `docker-compose.yaml` con valores de DB y dominios para Nginx y Let's Encrypt
* Iniciar server con `docker-compose up -d`

## Despues de iniciar

Configurar tu usuario para que sea owner:

`docker exec -it  -w /app/www <container-id> bin/tootctl accounts modify <my-user> --role Owner`

## Toques finales

Si estas usando un subdominio (`mastodon.ejemplo.com` en lugar de `mastodonargentina.com`) tenes que crear un 301 para que los servers federados encuentren tus usuarios

```
server {
    listen       80;
    server_name  localhost;

    location /.well-known/host-meta {
        return 301 https://mastodon.ejemplo.com$request_uri;
    }

    location / {
        return 301 https://www.ejemplo.com$request_uri;
    }

}
```
