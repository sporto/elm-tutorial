# Hola Mundo
## Instalando Elm

Anda a http://elm-lang.org/install y descarga el instalador apropiado para tu sistema.

## Nuestra primera aplicación Elm
Vamos a escribir nuestra primera aplicación en Elm. Crea una carpeta para tu aplicación. En esta carpeta ejecuta el siguiente comando en la terminal:

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

Anda a esta carpeta en la terminal y escribe:

```bash
elm reactor
```

Veras lo siguiente:

```
elm reactor 0.17.0
Listening on http://0.0.0.0:8000/
```

En un explorador, abre `http://0.0.0.0:8000/`. Haz click en `Hello.elm`. Deberías ver `Hello` en el explorador.

Nota que hay una advertencia acerca de la falta de anotación de la funcion `main`. Ignora esto por ahora, vamos a aprender acerca de anotaciones más tarde.

Revisemos lo que está sucediendo aquí:

### Declaración de módulos

```
module Hola exposing (..)
```

Cada módulo en Elm debe comenzar con una declaración `module`, en este caso el nombre del módulo se llama `Hola`. Es una convención nombrar el archivo y el módulo con el mismo nombre, por ejemplo,`Hola.elm` contiene `module Hola`.

La parte `exposing (..)` en la declaración especifica que función y tipos se exponen en este módulo. Estas funciones y tipos pueden ser importardos por otros modulos. En este caso exponemos todo usando `(..)`.

### Imports

```
import Html exposing (text)
```

En Elm necesitas importar los __modulos__ que deseas utilizar de forma explícita. En este caso queremos usar el módulo __Html__.

Este módulo tiene muchas funciones para trabajar con HTML. Nosotros vamos a usar `.text`, por lo que importamos esta función usando ` exposing (text)`.

### Main

```
main =
    text "Hello"
```

Las aplicaciones de Front End en Elm comienzan en una función llamada `main`. `main` es una función que produce un elemento para ser dibujado en la página. En este caso se regresa un elemento HTML (creado al usar `text`).  

### Elm reactor

Elm __reactor__ crea un servidor que compila el código de Elm sobre la marcha. __reactor__ es útil para el desarrollo de aplicaciones sin tener que preocuparse en crear un proceso mas complejo. Sin embargo __reactor__ tiene limitaciones, por lo que más adelante, tendremos que cambiar a un proceso de construcción.
