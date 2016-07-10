# Imports et modules

Avec Elm, vous pouvez importer un module en utilisant le mot-clé `import`:

```
import Html
```

Cela a pour effet d'importer le module `Html` fourni avec Elm. Vous pouvez alors utiliser des fonctions et des types de ce module en utilisant leur chemin complet :

```
Html.div [] []
```

Vous pouvez aussi importer des modules et exposer des fonctions ou des types de ce module :

```
import Html exposing (div)
```

`div` est alors inclus dans le scope courant. Vous pouvez l'utiliser directement :

```
div [] []
```

Vous pouvez même exposer tout ce que contient un module :

```
import Html exposing (..)
```

Vous devriez alors être capable d'utiliser chaque fonction et chaque type de ce module directement. Mais généralement, il est déconseillé de faire ainsi pour des raisons d'ambiguité et de conflits possibles entre les modules.

## Modules et types avec le même nom

Beaucoup de modules exportent des types avec le même nom que le module. Par exemple, le module `Html` a un type `Html` et le module `Task` a un type `Task`.

Ainsi, cette fonction qui retourne un élément `Html` :

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

Est équivalente à :

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

Dans le premier exemple nous importons uniquement le module `Html` et utilisons le chemin complet `Html.Html`.

Dans le deuxième, nous exposons le type `Html` du module `Html` et utilisons le type `Html` directement.

## Déclarations de modules

Lorsque vous créez un module avec Elm, vous ajoutez la déclaration `module` en haut du fichier :

```
module Main exposing (..)
```

`Main` est le nom du module. `exposing (..)` signifie que vous souhaitez exposer toutes les fonctions et les types de ce module. Elm s'attend à trouver ce module dans un fichier appelé __Main.elm__, c'est à dire un fichier avec le même nom que le module.

Vous pouvez avoir des structures de fichiers plus profondes au sein d'une application. Par exemple, le fichier __Players/Utils.elm__ devrait avoir la déclaration :

```
module Players.Utils exposing (..)
```

Vous pourrez alors importer ce module de n'importe où en utilisant :

```
import Players.Utils
```




