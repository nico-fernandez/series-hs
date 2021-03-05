data Serie = UnaSerie {
    titulo :: String,
    actores :: [Actor],
    presupuesto :: Float,
    cantTemporadas :: Int,
    estaVigente :: Bool
}
    deriving Show

narcos = UnaSerie {
    titulo = "Narcos",
    actores = [mauricio, pedro, maria],
    presupuesto = 42323,
    cantTemporadas = 6,
    estaVigente = False
}
 
strangerThings = UnaSerie {
    titulo = "Stranger Things",
    actores = [mauricio, jesee, jack],
    presupuesto = 100003,
    cantTemporadas = 3,
    estaVigente = True
}

treceRazones = UnaSerie {
    titulo = "Trece Razones Porque",
    actores = [penny, maria],
    presupuesto = 500000,
    cantTemporadas = 5,
    estaVigente = True
}

breakingBad = UnaSerie {
    titulo = "Breaking Bad",
    actores = [jesee, walter],
    presupuesto = 780000,
    cantTemporadas = 5,
    estaVigente = False
}

simpsons = UnaSerie {
    titulo = "Los Simpsons",
    actores = [homero],
    presupuesto = 120000,
    cantTemporadas = 32,
    estaVigente = True
}

data Actor = Actor {
    nombre :: String,
    pais :: String,
    salario :: Float,
    papel :: Papel
}
    deriving Show

data Papel = Extra|Secundario|Principal 
    deriving (Eq, Ord, Show)

homero = Actor {nombre = "Homero Simpson", pais = "EEUU", salario = 0, papel = Principal}
jack = Actor {nombre = "Jack Sparrow", pais = "Uganda", salario = 30000, papel = Principal}
jesee = Actor {nombre = "Jesee Pinkman", pais = "EEUU", salario = 40000, papel = Secundario}
walter = Actor {nombre = "Walter White", pais = "Canada", salario = 450000, papel = Principal}
penny = Actor {nombre = "Penny Wise", pais = "Australia", salario = 23000, papel = Extra}
maria = Actor {nombre = "Maria Lopez", pais = "Argentina", salario = 2.5, papel = Principal}
pedro = Actor {nombre = "Pedro Picapiedra", pais = "Australia", salario = 23478, papel = Secundario}
mauricio = Actor {nombre = "Mauricio Gomez", pais = "Eslovaquia", salario = 30000, papel = Extra}

-- si está en rojo, esto es si el presupuesto no alcanza a cubrir lo que cobran todos los actores



salarioTotalActores actores = sum (map salario actores)
estaEnRojo :: Serie -> Bool
estaEnRojo serie = presupuesto serie < salarioTotalActores (actores serie)

-- si actúa un actor o actriz de un determinado país
hayAlgunActorDe :: String -> Serie -> Bool
hayAlgunActorDe paisDeInteres serie = any ((paisDeInteres==).pais) (actores serie)

-- si es muy extensa, es decir con más de 10 temporadas.
esMuyExtensa :: Serie -> Bool
esMuyExtensa serie = cantTemporadas serie > 10

-- si está cancelada
estaCancelada :: Serie -> Bool
estaCancelada = not.estaVigente


-------------------------------------------

-- estireitor: duplica la cantidad de temporadas estimada de la serie.
estireitor :: Serie -> Serie
estireitor serie = serie {cantTemporadas = cantTemporadas serie * 2}

-- serrucheitor: le recorta el presupuesto en un porcentaje dado
serrucheitor :: Float -> Serie -> Serie
serrucheitor porcentaje serie = serie {presupuesto = presupuesto serie - (presupuesto serie * (porcentaje / 100))}

-- gatopardeitor: no cambia nada de la serie.
gatopardeitor :: Serie -> Serie
gatopardeitor serie = serie

-- encapricheitor: elimina al actor o actriz más importante de la serie y lo reemplaza por su favorito.
encapricheitor :: Actor -> Serie -> Serie
encapricheitor nuevoActor serie = serie {actores = nuevoActor:(filter (\actor -> papel actor /= Principal) (actores serie))}

---------------------------------------------
tieneAlarmaApagada :: (Serie -> Bool) -> Serie -> Bool
tieneAlarmaApagada alarma serie = alarma serie == False

tienenAlarmaApagada :: (Serie -> Bool) -> [Serie] -> [Serie]
tienenAlarmaApagada alarma series = filter (tieneAlarmaApagada alarma) series

evaluacion :: [Serie] -> (Serie -> Bool) -> (Serie -> Serie) -> [Serie]
evaluacion series alarma productor = map (alarma . productor) (tienenAlarmaApagada series)

-- actores = cycle ["homero", "pedro", "juan"]
-- Listas infinitas
-- Si tengo una serie con infinitos actores evaluo si puedo aplicarle las alarmas
-- estaEnRojo No funciona porque compara un numero con infinito, es decir el salario de los actores es infiniyo
-- hayAlgunActorDe Tampoco funciona porque siempre esta buscando algun actor que corresponda
-- esMuyExtensa Si funciona porque no evalua los actores
-- estaCancelada Tambien funciona por la misma razon

-- Si tengo infinitas series no puedo trabajar ya que el programa nunca terminara de evaluarlas




-- Consultas

-- Main> hayAlgunActorDe "Argentina" breakingBad
-- False

-- Main> hayAlgunActorDe "Argentina" treceRazones
-- True

-- Main> encapricheitor narcos maria
-- UnaSerie {titulo = "Narcos", actores = [Actor {nombre = "Maria Lopez", pais = "Argentina", salario = 2.5, papel = Principal},
-- Actor {nombre = "Pedro Picapiedra", pais = "Australia", salario = 23478.0, papel = Secundario},Actor {nombre = "Mauricio 
-- Gomez", pais = "Eslovaquia", salario = 30000.0, papel = Extra}], presupuesto = 42323.0, cantTemporadas = 6, estaVigente = 
-- False}

-- Main> evaluacion [breakingBad, simpsons] estireitor esMuyExtensa
-- [UnaSerie {titulo = "Los Simpsons", actores = [Actor {nombre = "Homero Simpson", pais = "EEUU", salario = 0.0, papel = 
-- Principal}], presupuesto = 120000.0, cantTemporadas = 32, estaVigente = True}]

-- Main> estaCancelada breakingBad
-- True

-- Main> serrucheitor 43 simpsons
-- UnaSerie {titulo = "Los Simpsons", actores = [Actor {nombre = "Homero Simpson", pais = "EEUU", salario = 0.0, papel = 
-- Principal}], presupuesto = 68400.0, cantTemporadas = 32, estaVigente = True}

-- *Main> estaEnRojo treceRazones 
-- False