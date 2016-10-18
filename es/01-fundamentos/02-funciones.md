# Conceptos básicos de función

Este capítulo trata la sintaxis básica de Elm, ya que es importante familiarizarse con: funciones, firmas de función, aplicación parcial y el operador "pipe".

## Funciones

Elm soporta dos tipos de funciones:

- funciones anónimas
- funciones nombradas

### Funciones anónimas

Una función anónima, como su nombre lo indica, es una función sin nombre:

```elm
\x -> x + 1

\x y -> x + y
```

Entre la barra invertida y la flecha, se listan los argumentos de la función, y a la derecha de la flecha, decimos qué hacer con esos argumentos.

### Funciones nombradas

Una función nombrada en Elm luce como:

```elm
add1 : Int -> Int
add1 x =
  x + 1
```

- La primer línea en este ejemplo es la firma de la función. Esta firma es opcional en Elm, pero es recomendable por que hace más clara la implementación de tus funciones.
- El resto es la implementación de la función, la implementación debe seguir la firma definida arriba.

En este caso la firma dice: Dado un entero (Int) como un argumento regresa otro entero.

Tu puedes llamar esta función haciendo:

```
add1 3
```

En Elm usamos *espacio* para denotar la aplicación de funciones (en vez de usar paréntesis).

Aqui otra función nombrada:

```elm
add : Int -> Int -> Int
add x y =
  x + y
```

Esta función toma dos argumentos (ambos enteros) y regresa otro entero. Tu puedes llamar esta función haciendo:

```elm
add 2 3
```

### Sin argumentos

Una función que no toma argumentos es una constante en Elm:

```elm
name =
  "Sam"
```

### Como son aplicadas las funciones

Como se muestra arriba una función que toma dos argumentos podría lucir como:

```elm
divide : Float -> Float -> Float
divide x y =
    x / y
```

Podemos pensar en esta firma como una función que toma dos flotantes y regresa otro flotante:

```elm
divide 5 2 == 2.5
```

Sin embargo, esto no es del todo cierto, en Elm todas las funciones toman exactamente un argumento y devuelven un resultado. Este resultado puede ser otra función.

Vamos a explicar esto usando la función anterior:


```elm
-- Cuando ejecutamos:

divide 5 2

-- Esto es evaluado como:

((divide 5) 2)

-- Primero `divide 5` es evaluado.
-- El argumento `5` es aplicado en `divide`, resultando en una función intermediaria.

divide 5 -- -> función intermediaria

-- Llamemoes esta función intermediaria `divide5`.
-- Si pudieramos ver la firma y cuerpo de la función intermediaria, se vería como:

divide5 : Float -> Float
divide5 y =
  5 / y

-- Por tanto tenemos una función que ya tiene aplicado el argumento `5`.

-- Luego el siguiente argumento `2` es aplicado

divide5 2

-- Y esto regresa el resultado final
```

La razón por la que podemos evitar escribir paréntesis se debe a que la aplicación de funciones **asocia a la izquierda**.

### Agrupación con paréntesis

Cuando se quiere llamar a una función con el resultado de otra función, es necesario utilizar paréntesis para agrupar las llamadas:

```elm
add 1 (divide 12 3)
```

Aquí el resultado de `divide 12 3` es dado a `add` como el segundo parámetro.

En contraste, en muchos otros lenguages esto podría haber sido escrito como:

```js
add(1, divide(12, 3))
```

## Aplicación parcial

Como se explicó anteriormente cada función sólo toma un argumento y devuelve otra función o resultado.
Esto significa que puedes llamar a una función como `add` con sólo un argumento, por ejemplo `add 2` y obtener una *función parcialmente aplicada** de regreso.

Esta función resultante tiene una firma `Int -> Int`.

```elm
add2 = add 2
```

`add 2` devuelve otra función con el valor `2` como el primer parámetro. Al usar esta funcion intermediaria con un segundo valor obtenemos un resultado final.

```elm
add2 3 -- regresa 5
```

La aplicación parcial es increíblemente útil en Elm para hacer el código más legible y pasar estado entre las funciones de la aplicación.

## El operador "pipe"

Como se muestra arriba se pueden anidar funciones como:

```elm
add 1 (multiply 2 3)
```

Esto es un ejemplo trivial, pero considera un ejemplo más complejo:

```elm
sum (filter (isOver 100) (map getCost records))
```

Este código es difícil de leer, ya que resuelve de adentro hacia afuera. El operador pipe nos permite escribir estas expresiones de una manera más legible:

```elm
3
    |> multiply 2
    |> add 1
```

Esto posible gracias a la aplicación parcial como se ha explicado antes. En este ejemplo el valor `3` se pasa a una función aplicada parcialmente `multiply 2`. Su resultado es a su vez pasado a otra función aplicada parcialmente `add 1`.

Utilización del operador "pipe" el ejemplo complejo anterior se escribiría como:

```elm
records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```
