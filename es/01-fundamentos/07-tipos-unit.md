# El tipo unidad

En Elm la tupla vacia `()` llama a la __unit type__ .  Es tan frecuente que se merece alguna explicación.

Considere un alias de tipo con una __type variable__ (representada por `a`):

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

Se puede hacer una función que espera un `Message` con el `body` como un `String` como esto:

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

O una función que espera un `Message` con el `body` como una lista de enteros:

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

Pero ¿qué pasa con una función que no necesita un valor en el cuerpo? Utilizamos el tipo de unidad para indicar que el cuerpo debe estar vacío:

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

Esta función toma a `Message` con un __empty body__. Esto no es lo mismo que __any value__, solo un  __empty__.

Por lo que el tipo de unidad se usa comúnmente como un marcador de posición para un valor vacío.

## Tarea

Un ejemplo real de esto es el tipo `Task`. Cuando usamos `Task`, verá el tipo de unidad muy a menudo.

Una tarea tipica tiene un __error__ y un __result__:

```elm
Task error result
```

- A veces queremos una tarea en la que puede hacer caso omiso del error: `Task () result`
- O el resultado es ignorado: `Tasks error ()`
- O ambos: `Task () ()`
