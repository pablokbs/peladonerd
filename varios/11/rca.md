# RCA del Incidente 20201230A

## Descripción del problema

El dia 30/12/2020, nuestro servicio de cobros fue interrumpido por 35 minutos. Nuestro servicio de búsqueda de productos y otros servicios importantes no se vieron afectados y funcionaron normalmente.  

## Causa raíz

El servicio de cobros depende de una base de datos en Mongo que está hosteada en un servicio externo. Durante un ejercicio programado de mantenimiento, el equipo de base de datos se dio cuenta que los discos de un servidor estaba teniendo problemas, por lo que se decidió reemplazarlo.
Normalmente esto no debería ser un problema ya que usamos RAID 5, pero al parecer también había una configuración errónea en el RAID y la replicación de datos estaba particularmente lenta.
Al reemplazar unos de los discos, la replicación de datos usó todos los recursos del sistema y esto causó un cuello de botella en los servidores de base de datos, que impactó directamente en el rendimiento de nuestro servicio de cobros.

## Remediación y prevención

Nuestros equipos de ingeniería fueron alertados de que el servicio de cobro estaba mostrando un gran número de errores al mismo tiempo que la replicación de datos comenzó. 5 minutos después, el equipo a cargo del mantenimiento detectó el problema y decidió detener la replicación de datos removiendo el nuevo disco. Unos pocos minutos después, el servicio de base de datos estaba funcionando correctamente, y nuestro servicio de cobros empezó a recuperarse. Luego de 35 minutos, todos nuestros servicios estaban funcionando con normalidad.

Una vez que la replicación fue detenida y el disco removido, se procedió a revisar la configuración del RAID y se encontró el problema con la configuración. El equipo de base de datos replicó este mismo escenario en un servidor de prueba y pudo reproducir el problema. Después de hacer el cambio en la configuración y probar que la replicación no afecte al servicio en el servidor de prueba, se procedió a hacer el mismo cambio en el servidor de producción. El servidor de producción se comportó de la forma esperada y el RAID funciona correctamente.

Nuestro sistema de configuraciones fue actualizado para que este error no vuelva a suceder.

## Descripción detallada del impacto


El 30/12/2020 desde las 9:46 AM (UTC -3) y las 10:21 AM (UTC -3) nuestro servicio de cobros no estaba disponible. 

* Servicio de cobros: No era posible completar compras y los clientes recibían un mensaje de error al tratar de cargar su tarjeta de crédito.
* Servicio de búsqueda: No fue afectado
* Servicio de notificaciones: No fue afectado
