# Tipos alias

Un __tipo alias__ en Elm es, como su nombre lo indica, un alias para otra cosa. Por ejemplo, en Elm tienes tipos basicos `Int` y `String`. Puede crear alias para ellos:

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

Aquí hemos creado un par de tipos alias que apuntan simplemente a otros tipos. Esto es útil porque en lugar de tener una función como:

```elm
label: Int -> String
```

Podeos escribirla como:

```elm
label: PlayerId -> PlayerName
```

De esta manera, es mucho más claro lo que la función está pidiendo.

## Registros

Una definición de registro (record) en Elm se ve como:

```elm
{ id : Int
, name : String
}
```

Si tienes una función que toma un registro, tendrías que escribir una firma de esta manera:

```elm
label: { id : Int, name : String } -> String
```

Bastante complicado, pero los tipos alias ayudan con esto:

```elm
type alias Player =
    { id : Int
    , name : String
    }

label: Player -> String
```

Aquí creamos un tipo alias `Player` que apunta a una definición de registro. Luego usamos ese tipo de alias en la firma de la función.

## Constructores

Los tipos alias pueden ser usados como funciones __constructoras__. Lo que significa que podemos crear un record real utilizando el tipo de alias como una función.

```elm
type alias Player =
    { id : Int
    , name : String
    }

Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

Aqui creamos un tipo alias `Player`. Luego llamamos a `Player` como una función con dos argumentos. Esto nos devuelve un registro con los atributos apropiados. Ten en cuenta que el orden de los argumentos determina qué valores serán asignados a los atributos.
