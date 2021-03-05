Nos contactaron para hacer un sistema que ayude a tomar decisiones sobre series de TV a producir en un nuevo servicio llamado Prime Pdep. En el sistema vamos a trabajar con series, de las cuales queremos saber cuál es su nombre, quiénes actúan en ella (en orden de importancia), su presupuesto total, la cantidad de temporadas y si está vigente o cancelada.

También, de cada actor o actriz conocemos el nombre, su país de origen y cuál es su sueldo pretendido.

Resolver los siguientes requerimientos, haciendo correcto uso de composición, aplicación parcial y orden superior cuando sea conveniente.

1. Queremos modelar ciertas alarmas que se pueden "encender" en cualquiera de las series

si está en rojo, esto es si el presupuesto no alcanza a cubrir lo que cobran todos los actores
si actúa un actor o actriz de un determinado país
si es muy extensa, es decir con más de 10 temporadas.
si está cancelada

2. Queremos modelar diferentes tipos de productores, que hacen su trabajo con las series:

* estireitor: duplica la cantidad de temporadas estimada de la serie.
* serrucheitor: le recorta el presupuesto en un porcentaje dado
* gatopardeitor: no cambia nada de la serie.
* encapricheitor: elimina al actor o actriz más importante de la serie y lo reemplaza por su favorito.

3. Y lo más importante: Hacer que dado un conjunto de series, un productor y una alarma, se obtengan todas las series para las cuales, como consecuencia del trabajo de un productor en todas ellas, la alarma se "enciende". (Que previo al trabajo del productor estaba "apagada" 0

Por ejemplo:
CSI es una serie de 8 temporadas, Los Simposon tiene 25, Merli 3 y Lost 9. Al analizar que sucede cuando un estireitor trabaja en todas ellas, y considerando la alarma de mucha extensión, encontramos que las series para las que se enciende dicha alarma son CSI y Lost (Los Simpsons ya era muy extensa anteriormente y Merli aún con 6 temporadas no llega a ser extensa)
Plantear el caso de un encapricheitor con un actor argentino y la alarma de que el país sea argentina