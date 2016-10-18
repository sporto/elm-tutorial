# Tipos alias

Un __type alias__ en Elm es, como su nombre lo dice, un alias para otra cosa. Por ejemplo, en Elm tienes el core los tipos `Int` y `String`. Puede crear alias para ellos:

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

Aquí hemos creado un par de tipos alias que apuntan simplemente a otros tipos. Esto es útil porque en lugar de tener una función como:

```elm
label: Int -> String
```

Se puede escribir como:

```elm
label: PlayerId -> PlayerName
```

De esta manera, es mucho más claro lo que la función está pidiendo.

## Records

Una definición de record en Elm parece:

```elm
{ id : Int
, name : String
}
```

Si usted tuviera una función que toma un record, usted tendría que escribir una firma como:

```elm
label: { id : Int, name : String } -> String
```

Bastante detallado, pero los alias de tipo ayudan mucho con esto:

```elm
type alias Player =
    { id : Int
    , name : String
    }

label: Player -> String
```

Aquí creamos un tipo alias `Player` que apunta a una definición de record. Luego usamos ese tipo de alias en nuestra firma de la función.

## Constructores

Los tipos alias pueden ser usados como funciones __constructor__. Lo que significa que podemos crear un record real utilizando el tipo de alias como una función.

```elm
type alias Player =
    { id : Int
    , name : String
    }

Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

Aqui creamos un tipo alias`Player`. Entonces, llamamos a `Player` como una función con dos parámetros. Esto nos devuelve un record con los atributos apropiados. Tenga en cuenta que el orden de los argumentos determina qué valores serán asignados a los atributos.
