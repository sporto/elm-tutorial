> This page covers Elm 0.17

# Main

Enfin, il nous reste à brancher tout ça ensemble dans le module Main.

Modifiez __src/Main.elm__ comme ceci :

```elm
module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
```

---

### Nouveaux imports

On a ajouté les imports pour `Navigation` et `Routing`.

### Init

```elm
init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

Notre fonction `init` prend désormais une valeur en entrée, passée par le `parser` qu'on a ajouté dans [Routage](07-routing/02-routing.md). Le parser renvoie un `Result`. Le module `Navigation` va parser l'adresse initiale et passer le résultat à `init`. On va stocker cette `Route` initiale dans notre modèle.

### urlUpdate

`urlUpdate` sera appelée par le module `Navigation` à chaque fois que l'adresse du navigateur changera. Comme dans `init`, on obtient le résultat de norte parser. Dans notre exemple, on se contente de stocker la nouvelle `Route` dans notre modèle d'application.

### main

`main` utilise désormais `Navigation.program` plutôt que `Html.App.program`. `Navigation.program` enveloppe `Html.App` mais ajoute une fonction `urlUpdate` appelée quand l'adresse du navigateur change.
