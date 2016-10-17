# Más sobre funciones

## Tipos de variables

Considere una función con una tipo de firma como:

```elm
indexOf : String -> List String -> Int
```

Esta función hipotética toma una cadena y una lista de cadenas y regresa el índice donde se encontró la cadena dada en la lista ó -1 si no se encuentra.

Pero ¿y si en lugar de tener una lista de números enteros? No seríamos capaces de utilizar esta función. Sin embargo, podemos hacer esta función __generic__ mediante el uso de __type variables__ o __stand-ins__ en lugar de tipos específicos.

```elm
indexOf : a -> List a -> Int
```

Mediante el reemplazo de `String` con `a`, la firma ahora dice que` indexOf` toma un valor de cualquier tipo `a` y una lista de ese mismo tipo `a` y devuelve un entero. Mientras los tipos coinciden con el compilador será feliz. Puedes llamar  `indexOf` con un `String` y una lista de `String`, o un `Int` y una lista de `Int`, y funcionará.

De esta manera las funciones se pueden hacer más genéricas. Puedes tener varias variables __type variables__ así:

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

Estas funciones toman una tupla de tipos `a`, `b` y regresan una tupla de tipos `b`, `a`. Todas estas son llamadas válidas:  

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```

Ten en cuenta que cualquier identificador en minúsculas se puede utilizar para los tipos de  variables, `a` y `b` son sólo una convención común. Por ejemplo la siguiente firma es perfectamente válida:

```
indexOf : -> thing -> List thing -> Int
```

## Funciones como argumentos

Considere la posibilidad de una firma como:

```elm
map : (Int -> String) -> List Int -> List String
```

Esta función:

- Tiene una función: El `(Int -> String)` parte
- Una lista de enteros
- y regresa una lista de strings

La parte interesante es el fragmento `(Int -> String)`. Este dice que una función se debe dar conforme a la firma `(Int -> String)`.

Por ejemplo, `toString` desde el núcleo es tal función. Por lo que podría llamar a este función `map` como:

```elm
map toString [1, 2, 3]
```

Pero `Int` y `String` son demasiado específicos. Así que la mayoría de las veces se usan firmas por medio de stand-ins en su lugar:

```elm
map : (a -> b) -> List a -> List b
```

Esta función asigna una lista de `a` a una lista de `b`. En realidad, no importa lo que `a` y `b` representan mientras que la función dada en el primer argumento utilize los mismos tipos.

Por ejemplo, las funciones con estas firmas dadas:

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

Podemos llamar el mapa genérico como:

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
