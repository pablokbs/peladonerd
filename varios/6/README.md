## Tomado de: https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

* Crea un archivo docker-compose.yaml

```yaml
version: '2'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
     - ./openvpn-data/conf:/etc/openvpn
```

* Inicializa los archivos de configuracion y certificados

```bash
docker-compose run --rm openvpn ovpn_genconfig -u udp://<IP-DE-TU-SERVIDOR>
docker-compose run --rm openvpn ovpn_initpki
```

* Arregla tus permisos (puede no ser necesario si ya estás haciendo todo con root)

```bash
sudo chown -R $(whoami): ./openvpn-data
```

* Inicia el contenedor de OpenVPN

```bash
docker-compose up -d
```

* Puedes ver los logs de contenedor con:

```bash
docker-compose logs -f
```

* Generar un certificado de cliente

```bash
export CLIENTNAME="el_nombre_del_cliente"
# con contraseña
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# sin contraseña
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

* Crea el archivo de configuración del cliente

```bash
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

* Revoca el certificado de un cliente

```bash
# Dejando los archivos crt, key y req.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
# Borrando los correspondientes archivos crt, key y req.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```