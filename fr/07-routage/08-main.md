> Cette page couvre Elm 0.18

# Main

Enfin, il nous reste à brancher tout ça ensemble dans le module Main.

Modifiez __src/Main.elm__ comme ceci :

```elm
module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```
---

### Nouveaux imports

Nous avons ajouté les imports pour `Navigation` et `Routing`.

### Init

```elm
init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

Notre fonction `init` prend désormais une `Location` en entrée venant de `Navigation`. Nous analysons cette `Location` en utilisant la fonction `parseLocation` que nous avons créée auparavant. Nous stockons ensuite cette `Route` initiale dans notre modèle.

### main

`main` utilise désormais `Navigation.program` plutôt que `Html.program`. `Navigation.program` enveloppe `Html.program` et déclenche un message lorsque l'adresse du navigateur change. Dans notre cas, ce message sera `OnLocationChange`.
