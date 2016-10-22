# Más sobre funciones

## Tipos de variables

Considera una función con una firma como:

```elm
indexOf : String -> List String -> Int
```

Esta función hipotética toma una cadena y una lista de cadenas y regresa el índice donde se encontró la cadena dada en la lista ó -1 si no se encuentra.

¿Pero que sucede si tenemos una lista de números enteros? No seríamos capaces de usar esta función. Sin embargo, podemos hacer esta función __generica__ mediante el uso de __type variables__ o __stand-ins__ en lugar de tipos específicos.

```elm
indexOf : a -> List a -> Int
```

Mediante el reemplazo de `String` con `a`, la firma ahora dice que` indexOf` toma un valor de cualquier tipo `a` y una lista de ese mismo tipo `a` y devuelve un entero. Mientras los tipos coincidan, el compilador será feliz. Puedes llamar  `indexOf` con un `String` y una lista de `String`, o un `Int` y una lista de `Int`, y funcionará.

De esta manera las funciones se pueden hacer más genéricas. Puedes tener varias variables __type variables__ así:

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

Esta funcion toman una tupla de tipos `a`, `b` y regresan una tupla de tipos `b`, `a`. Todas estas son llamadas válidas:  

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```

Ten en cuenta que cualquier identificador en minúsculas se puede utilizar para las variables de tipo, `a` y `b` son sólo una convención común. Por ejemplo la siguiente firma es perfectamente válida:

```
indexOf : thing -> List thing -> Int
```

## Funciones como argumentos

Considera la posibilidad de una firma como:

```elm
map : (Int -> String) -> List Int -> List String
```

Esta función:

- Acepta una función como primer argumento: `(Int -> String)`
- una lista de enteros como segundo argumento
- y regresa una lista de strings

La parte interesante es el fragmento `(Int -> String)`. Esto dice que se debe pasar una función que conforme a la firma `(Int -> String)`.

Por ejemplo, `toString` de Elm core es tal función. Por lo que podrías llamar a este función `map` haciendo:

```elm
map toString [1, 2, 3]
```

Pero `Int` y `String` son demasiado específicos. Así que la mayoría de las veces se usan firmas con "stand-ins" en su lugar:

```elm
map : (a -> b) -> List a -> List b
```

Esta función convierte una lista de `a` a una lista de `b`. En realidad, no importa lo que `a` y `b` representan mientras que la función dada en el primer argumento utilize los mismos tipos.

Por ejemplo, funciones con estas firmas:

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

Pueden ser usadas con el `map` genérico:

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
