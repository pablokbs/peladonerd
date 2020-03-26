###Descargar y flashear Raspbian:

Descargar [Rasbian Buster with desktop](https://www.raspberrypi.org/downloads/raspbian/)


###Configurar kiosk

#### Instalar dependencias

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install xdotool unclutter sed
```

#### Configurar raspberry para que inicie UI

```
sudo raspi-config
```

Ir a **3 Boot options -> B1 Desktop / CLI -> B4 Desktop Autologin**

#### Configurar /home/pi/kiosk.sh para que inicie Chrome

Ahora que tenemos el inicio automático de la UI, vamos a configurar el script en `/home/pi/kiosk.sh`


```
#!/bin/bash
xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk http://localhost:8081 &

while true; do
   # Si pusiste 2 URLs para abrir en la linea de arriba, podes ir cambiando entre ellas con la siguiente linea
   # xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
   # Vamos a refrescar cada 10 min
   xdotool keydown ctrl+r; xdotool keyup ctrl+r;
   sleep 600
done
```

#### Crear servicio

`sudo vim /lib/systemd/system/kiosk.service`

```
[Unit]
Description=Chromium Kiosk
Wants=graphical.target
After=graphical.target

[Service]
Environment=DISPLAY=:0.0
Environment=XAUTHORITY=/home/pi/.Xauthority
Type=simple
ExecStart=/bin/bash /home/pi/kiosk.sh
Restart=on-abort
User=pi
Group=pi

[Install]
WantedBy=graphical.target
```

### Instalar docker

Instalemos Docker para correr nuestra web personalizada

```
apt-get update && apt-get install docker.io docker-compose vim
```

Agregamos el user `pi` al grupo `docker`:

```
sudo usermod -a -G docker pi
```

Copiamos el `docker-compose.yaml` que está en este repo e iniciamos el servicio

```
docker-compose up -d 
```

Útiles:

```
# refrescar pagina
DISPLAY=:0 xdotool keydown ctrl+r; xdotool keyup ctrl+r
# zoom in
DISPLAY=:0 xdotool keydown ctrl+plus; xdotool keyup ctrl+plus
# zoom out
DISPLAY=:0 xdotool keydown ctrl+minus; xdotool keyup ctrl+minus
# reset zoom
DISPLAY=:0 xdotool keydown ctrl+0; xdotool keyup ctrl+0
```

Configuramos crontab para que la pantalla se apague a las 19:00 y se prenda a las 10:00

```
$ crontab -e

0 10 * * * DISPLAY=:0.0 xset dpms force on
0 19 * * * DISPLAY=:0.0 xset dpms force off
```


