| Puntos | Resumen | Solución | Esfuerzo |
|:------:| --------|----------|----------|
|1|**Insignificante**, cambio de una linea, typo|Obvia, **cero** incertidumbre|**Simple**, podría hacer muchos de estos por día.
|2|Cambio **mínimo**, cambios de configuración|Conocida, **casi nada** de incertidumbre|Bastante **fácil**, un code re view para checkear rápido|
|3|**Pequeño**, un feature específico, investigación o colaboración con otros equipos **insignificante**|Generalmente conocida, poca **incertidumbre**|Voy a necesitar **enfocarme**, requiere **code review y tests** con esfuerzo, necesita **una** sesión de concentración.
|5|Feature **compleja**, requiere **muy poca** investigación o colaboración con otros equipos|Tengo una idea, **investigación limitada a conocida** incertidumbre|La complejidad o cantidad de trabajo requiere **un par** de sesiones de concentración|
|8|Feature **compleja o grande**, requiere **un poco** de investigación|El concepto y los objetivos son **conocidos**, la solución requiere **un poco** de investigación que solo puede ser lograda como parte del trabajo|La complejidad o cantidad de trabajo requiere **varias**  sesiones de concentración
|13|Feature **muy compleja o muy grande**, requiere una cantidad investigación y coordinación con otros equipos **significante**|El concepto y los objetivos son **conocidos**, la solución requiere **bastante** investigación que solo puede ser lograda como parte del trabajo|La complejidad o cantidad de trabajo requiere **muchas** sesiones de concentración


> ⚠️ Cualquier ticket con mas de 13 puntos, deberia ser dividido en tickets mas pequeños. Intenta crear tickets de investigación para poder definir el puntaje del ticket de una forma mas acertada.



|Bump|Testing|
|:--:|-------|
|Base|**Cero** esfuerzo extra haciendo testing, mas allá de las prácticas comunes|
|+1 paso|El esfuerzo de testing **excede las prácticas comunes** y es **igual** al esfuerzo de implementación|
|+2 pasos|El esfuerzo de testing **excede las prácticas comunes** y es **mayor** al esfuerzo de implementación|

|Bump|Riesgo|
|:--:|-------|
|Base|Todos los riesgos fueran del ticket, son **aceptados, resueltos** o **mitigados** |
|+1 paso|Riesgo **bajo a moderado** es aceptado dentro de este ticket|
|+2 pasos|Riesgo **moderado a alto** es aceptado dentro de este ticket|