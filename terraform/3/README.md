**Algunos cambios realizados:**:

1. **ClamAV Desactivado:** Si estan deployando en Digital Ocean no va a funcionar porque se come el procesador. Agregué DISABLE_CLAMAV=TRUE como variable de entorno en userdata.yaml.

Se van a quedar sin el antivirus, pero si usan Linux o tienen sentido común :man_shrugging:

2.  **SPF y DMARC:** Ahora también se generan estos dos registros en su dominio:

    - tudominio.com. TXT "v=spf1 mx ~all"
    - \_dmarc.tudominio.com. TXT "v=DMARC1; p=none; rua=mailto:dmarc-reports@tudominio.com"

3.  **CNAME para SMTP, POP, IMAP:** Algunos clientes por defecto van a buscar, por ejemplo, smtp.tudominio.com, por eso hice que se generen los siguientes CNAME:

    - smtp.tudominio.com. CNAME mail.tudominio.com.
    - pop.tudominio.com. CNAME mail.tudominio.com.
    - imap.tudominio.com. CNAME mail.tudominio.com.

4.  **Volumen:** Metí los datos en un volumen, así si por algún motivo se tiene que regenerar el droplet no se pierden los datos.

Pueden revisar el archivo 03_volume.tf para cambiar el tamaño del volumen generado. Tener en cuesta que el volumen tiene costo (u\$u 0.50 por 5gb).

Si desean usar el almacenamiento del droplet en vez de un volumen eliminar 03_volume.tf y reemplazar en userdata.yaml /mnt/mail:/data por /root/mail-data:/data

Agregué un prevent_destroy para evitar que Terraform accidentalmente elimine el volumen. Si por algún motivo molesta (Por ejemplo, generaron el volumen pero luego quieren cambiar el tamaño y no les interesa perder los datos) lo pueden quitar.

5.  **Eliminé la creación del dominio raiz:** Como ya tenia el dominio raiz generado de antes me fallaba porque intentaba regenerarlo. Por este motivo eliminé la creación del dominio raiz. Si no lo tienen generado en el DNS, primero pueden agregarlo manualmente.

6.  **Puse el dominio raiz en una variable:** Cuando apliquen estos scripts les va a preguntar el dominio. Recuerden ingresar el dominio raiz.

7.  **Cambie la interpolación de variables:** En Terraform 0.12 ya no hace falta el "\${variable}". Si es solo eso se puede poner la variable directamente y ahorrarse el warning. Recuerden usar Terraform > 0.12.

8.  **Usé la imágen de Debian 10:** Cuestión de gustos, si desean pueden cambiarlo por Ubuntu.

**Consejos luego de tener el servidor instalado:**:

1.  **DKIM:** Deben agregar el registro DKIM en su DNS. Lo pueden sacar desde _Virtual Domains > tudominio.com > DKIM key_

2.  **Usar un SMTP Relay:** En mi caso los e-mails no se mandaban. También hubo casos de gente que manda y a la otra persona le llega a spam. Para esto se puede configurar un relay en _System Setting > Email Processing > Default SMTP Route_. Pueden usar Sendgrid, Mailgun o cualquier otro :+1:

No olviden validar el dominio asi no le sale "Enviado desde sendgrid.net" o lo que sea al destinatario. En el caso de Sendgrid se hace [desde acá](https://app.sendgrid.com/settings/sender_auth/domain/create).
