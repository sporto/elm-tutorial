# Hola Mundo
## Instalando Elm

Ir a http://elm-lang.org/install y descargar el instalador apropiado para tu sistema.

## Nuestra primera aplicación Elm
Vamos a escribir nuestra primera aplicación Elm. Crear una carpeta para tu aplicación. En esta carpeta ejecutar el siguiente comando en la terminal:

```bash
elm package install elm-lang/html
```

Esto instalará el módulo _html_. A continuación, agrega un archivo `Hello.elm`, con el siguiente código:

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hola"
```

Ir a esta carpeta en la terminal y escribir:

```bash
elm reactor
```

Se mostrará lo siguiente:
```
elm reactor 0.17.0
Listening on http://0.0.0.0:8000/
```

En un explorador, abre `http://0.0.0.0:8000/`. Da click en `Hello.elm`. Deberías ver `Hello` en el explorador.

Nota que puedes ver una advertencia acerca de un tipo de falta de anotación `main`. Ignora esto por ahora, vamos a llegar a escribir anotaciones más tarde.

Vamos a revisar lo que está sucediendo aquí:

### Declaración de módulos

```
module Hola exposing (..)
```

Cada módulo en Elm debe comenzar con una declaración módulo, en este caso el nombre del módulo se llama `Hola`. Es una convención para nombrar el archivo y el módulo de la misma, por ejemplo,`Hola.elm` contains `module Hola`.

El `exposing (..)` parte de la declaración especifica que función y tipos se exponen en este módulo para importar otros modulos. En este caso exponemos todo `(..)`.

### Imports

```
import Html exposing (text)
```

En Elm necesitas importar los __modulos__ que deseas utilizar de forma explícita. En este caso queremos usar el módulo __Html__.

Este módulo tiene muchas funciones para trabajar con html. Nosotros vamos a usar `.text` por lo que importamos esta función dentro del namespace actual para usar ` exposing`.

### Main

```
main =
    text "Hello"
```

Aplicaciones de front end en Elm comienzan con una función llamada `main`. `main` es una función que regresa un elemento para dibujar en la página. En este caso se regresa un elemento HTML (creado por el uso de `Text`).  

### Elm reactor

Elm __reactor__ crea un servidor que compila el código de Elm sobre la marcha. __reactor__ es útil para el desarrollo de aplicaciones sin tener que preocuparse demasiado acerca de la creación de un proceso de construcción. Sin embargo __reactor__ tiene limitaciones, por lo que más adelante, tendremos que cambiar a un proceso de construcción.
