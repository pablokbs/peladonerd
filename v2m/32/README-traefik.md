> **@ElectronicaClavijo** alguien sabe si se puede hacer lo mismo pero con traefik ?

Si se puede, con un LoadBalancer en un [servicio HTTP de træfik](https://doc.traefik.io/traefik/routing/services/) utilizando un [**file** provider](https://doc.traefik.io/traefik/providers/file/) y funciona muy bien!

Esto permite utilizar træfik no sólo para enviar tráfico a containers si no también a aplicaciones corriendo en servidores on-premise (_siempre que el docker-host pueda llegar hasta ellos en la red_).

El primer requisito es que la configuración estática de træfik (**traefik.toml**) declare un [**file** provider](https://doc.traefik.io/traefik/providers/file/), para lo cual es más cómodo utilizar un directorio donde todos los ficheros `.toml` o `.yml` sean leídos automágicamente:

Sección a incluír en la configuración estática (**traefik.toml**):

```yaml
...
[providers]
  [providers.file]
  directory = "/etc/traefik/conf.d"
  watch = true
...
```

La configuración del servicio sería así:

```yaml
...
  [http.services]

    [http.services.my-app-1]

      [http.services.my-app-1.loadBalancer]
      passHostHeader = true

        [http.services.my-app-1.loadBalancer.healthCheck]
        path = "/"
        scheme = "http"
        interval = "30s"
        timeout = "10s"

        [[http.services.my-app-1.loadBalancer.servers]]
        url = "http://192.168.0.3:82"     # servidor con my-app-1
        # url = "http://192.168.0.4:82"   # otro servidor con my-app-1 (balanceo de carga)
```

La documentación de referencia del ejemplo anterior la encuentran en la sección "_**Load-balancing**_" de:
* [https://doc.traefik.io/traefik/routing/services/](https://doc.traefik.io/traefik/routing/services/)
