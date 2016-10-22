# Imports y módulos

En Elm puedes importar un módulo usando la palabra `import`, por ejemplo:

```elm
import Html
```

Esto importa el módulo `html`. A continuación, puedes utilizar las funciones y tipos de este módulo utilizando la ruta de acceso completa:

```elm
Html.div [] []
```

También puedes importar un módulo y exponer funciones y tipos específicos:

```elm
import Html exposing (div)
```

`div` se mezcla en el ámbito actual. Por lo tanto se puede utilizar directamente:

```elm
div [] []
```

Incluso puedes exponer todo en un módulo:

```elm
import Html exposing (..)
```

Asi podrias utilizar todas las funciones y tipos de este módulo directamente. Pero esto no es siempre recomendable, porque puede haber ambigüedad y posibles conflictos entre módulos.

## Módulos y tipos con el mismo nombre

Muchos modulos exportan tipos con el mismo nombre que el modulo. Por ejemplo, el módulo `Html` tiene un tipo `Html` y el módulo `Task` tiene un tipo `Task`.

Por lo que esta función que devuelve un elemento `html`:

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

Es equivalente a:

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

En el primer caso sólo importamos el módulo `Html` y utilizamos la ruta completa `Html.Html`.

En el segundo, se expone el tipo `Html` desde el módulo` Html`. Utilizando este tipo `Html` directamente.

## Declaraciones del módulo

Cuando creas un módulo en Elm, debes agregar la declaración `module` en la parte superior:

```elm
module Main exposing (..)
```

`Main` es el nombre del módulo. `exposing (..)` significa que desea exponer todas las funciones y tipos en este módulo. Elm espera encontrar este módulo en un archivo llamado __Main.elm__, es decir, un archivo con el mismo nombre que el módulo.

Puedes tener estructuras más profundas de archivos en una aplicación. Por ejemplo, el archivo
__Players/Utils.elm__ debe tener la declaración:

```elm
module Players.Utils exposing (..)
```

Serás capaz de importar este módulo desde cualquier lugar de tu aplicación usando:

```elm
import Players.Utils
```
