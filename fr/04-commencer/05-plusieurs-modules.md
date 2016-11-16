> This page covers Elm 0.17

# Plusieurs modules

Notre application va bientôt grossir, et si nous gardons tout le code dans un seul fichier, cela va être compliqué à maintenir.

### Dépendances circulaires

Il y a un autre problème que nous allons certainement rencontrer à un moment : les dépendances circulaires. Par exemple, on pourrait avoir :

- un module `Main` qui a un type `Player`
- un module `View` qui importe le type `Player` déclaré dans `Main`
- `Main` qui importe `View` pour afficher la vue

Cela créerait une dépendance circulaire :

```elm
Main --> View
View --> Main
```

#### Comment contourner le problème ?

Dans ce cas, il nous suffit d'extraire `Player` de `Main` et de le placer quelque part d'où il peut être importé par à la fois `Main` et `View`.

La manière la plus simple de traiter les dépendances circulaires en Elm est de séparer notre application en plusieurs petits modules. Dans notre exemple, nous allons créer un autre module qui pourra être importé par `Main` et `View`. Cela nous donnera trois modules :

- `Main`
- `View`
- `Models` (qui contient le type `Player`)

Désormais, les dépendances seront :

```elm
Main --> Models
View --> Models
```

Plus de dépendance circulaire !

Essayez de créer des modules séparés pour les éléments comme les __messages__, les __modèles__, les __commandes__ et les __utilitaires__, qui sont habituellement importés par de nombreux composants.

---

Décomposons notre application en modules plus petits :

__src/Messages.elm__

```elm
module Messages exposing (..)


type Msg
    = NoOp
```

__src/Models.elm__

```elm
module Models exposing (..)


type alias Model =
    String
```

__src/Update.elm__

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

__src/View.elm__

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src/Main.elm__

```elm
module Main exposing (..)

import Html.App
import Messages exposing (Msg)
import Models exposing (Model)
import View exposing (view)
import Update exposing (update)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Vous pouvez voir le code ici : <https://github.com/sporto/elm-tutorial-app/tree/03-multiple-modules>

---

Il y a beaucoup de petits modules. C'est probablement exagéré pour une application triviale. En revanche, pour une plus grosse application, cela permet de travailler beaucoup plus facilement.


