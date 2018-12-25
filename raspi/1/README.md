# Pasos para instalar Docker en una Raspberry PI 2/3 corriendo raspbian
Este es un instructivo para un tutorial en Youtube https://youtu.be/pliGG1M87W8

### 1. Descargar e instalar raspbian en tu micro SD
   * Descargar https://downloads.raspberrypi.org/raspbian_lite_latest
   * Descargar a instalar Etcher (para instalar en la SD) https://etcher.io/
   * Instalar imagen en la SD
  
### 2. Una vez que raspbian está instalado:
   * Cambiar password de usuario Pi (recomendado)

### 3. Instalar paquetes necesarios

```
 sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     vim \
     fail2ban \
     ntfs-3g
```

### 4. Instalar firmas GPG del repo de Docker

```
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
```

### 5. Agregar repo de Docker

```
echo "deb [arch=armhf] https://download.docker.com/linux/debian \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
```

### 6. Instalar Docker

```
sudo apt-get update && sudo apt-get install -y docker-ce docker-compose
```

### 7. Agregar usuario al grupo docker y desloguearse y volverse a loguear

```
sudo usermod -a -G docker kbs
#(logout and login)
```

### 8. Crear docker-compose
```
version: "2"

services:

  samba:
    image: dperson/samba:rpi
    restart: always
    command: '-u "pi;password" -s "media;/media;yes;no"'
    stdin_open: true
    tty: true
    ports:
      - 139:130
      - 445:445
    volumes:
      - /usr/share/zoneinfo/America/Argentina/Mendoza:/etc/localtime
      - /home/pi/media:/media
```


### 9. Iniciar docker-compose
```
docker-compose up -d
```
