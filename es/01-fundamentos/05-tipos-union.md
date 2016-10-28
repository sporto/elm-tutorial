# Tipos unión

En Elm, __(Union Types)__ se utilizan para muchas cosas, ya que son increíblemente flexible. Un tipo de unión se ve así:

```elm
type Answer = Yes | No
```

`Answer` puede ser `Yes` o `No`. Los tipos unión son útiles para hacer nuestro código más genérico. Por ejemplo, una función que se declara así:

```elm
respond : Answer -> String
respond answer =
    ...
```

Puede tomar `Yes` o `No` como primer argumento, por ejemplo, `respond Yes` es una aplicación válida.

En Elm los tipos unión también se les llama comúnmente __etiqueta (tags)__.

## Información

Los tipos unión pueden tener información asociada con ellos:

```elm
type Answer = Yes | No | Other String
```

En este caso, la etiqueta `Other` podría tener asociado una cadena. Podrías llamar `respond` de la siguiente manera:

```elm
respond (Other "Hello")
```

Es necesario el paréntesis de lo contrario Elm lo interpretará como que si estuvieras pasando dos argumentos a `respond`.

## Funciones como constructor

Fijate cómo añadimos información a `Other`:

```elm
Other "Hello"
```

Esto es igual que aplicar un argumento a una función, donde `Other` es la función. Los tipos unión se comportan igual que las funciones. Por ejemplo dado un tipo:

```elm
type Answer = Message Int String
```

Podremos crear una etiqueta `Message` usando:

```elm
Message 1 "Hello"
```

Puedes hacer una aplicación parcial al igual que cualquier otra función. Estos son comúnmente llamados `constructors` porque se pueden utilizar para construir tipos completos, por ejemplo, usar `Message` como una función de constructor `(Message 1 "Hello")`.

## Anidación

Es muy común anidar un tipo de unión en otro.

```elm
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

A continuación, podemos aplicar esta etiqueta a nuestra función `respond` (que esperar `Answer`) de esta forma:

```elm
respond (Other Perhaps)
```

## Tipos de variables

También es posible utilizar variables de tipo o stand-ins:

```elm
type Answer a = Yes | No | Other a
```

Este es un `Answer` que puede ser utilizado con diferentes tipos, por ejemplo: Int, String.

Por ejemplo, `respond` podria lucir asi:

```elm
respond : Answer Int -> String
respond answer =
    ...
```

Aquí estamos diciendo que el `a` stand-in debe ser de tipo `Int` mediante el uso de la firma `Answer Int`.

Así que más adelante podremos llamar `respond` usando:

```elm
respond (Other 123)
```

Pero `respond (Other "Hello")` fallaría porque `respond` espera un entero en lugar de `a`.

## Un uso común

Un uso típico de los tipos de unión es pasar valores a diferentes partes nuestro programa, donde el valor puede ser uno de un conjunto conocido de valores posibles.

Por ejemplo, en una aplicación web típica, tenemos acciones que se pueden realizar, como cargar usuarios, agregar usuarios, borrar usuarios, etc. Algunas de estas acciones tendrían información asociada.

Es común el uso de tipos de unión para esto:

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...

```

---

Hay bastante más para aprender sobre los tipos unión. Si te interesa leer más sobre esto [aquí](http://elm-lang.org/guide/model-the-problem).
