Comandos que corrí:

Buildear las 2 imagenes

```
$ docker build -t pablokbs/multiarch-helloworld:armhf armhf
$ docker build -t pablokbs/multiarch-helloworld:amd64 amd64
```

Pushear las 2 imagenes

```
$ docker push pablokbs/multiarch-helloworld:armhf
$ docker push pablokbs/multiarch-helloworld:amd64
```

Crear el manifest

```
$ docker manifest create pablokbs/multiarch-helloworld:latest \
   pablokbs/multiarch-helloworld:armhf \
   pablokbs/multiarch-helloworld:amd64
```

Docker manifest push

```
$ docker manifest push pablokbs/multiarch-helloworld:latest
```
