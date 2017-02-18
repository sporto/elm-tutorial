> This page covers Tutorial v2. Elm 0.18.

# Main

Finally we need to wire everything in the Main module.

Change __src/Main.elm__ to:

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

### New imports

We added imports for `Navigation` and `Routing`.

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

Our init function will now take an initial `Location` from the `Navigation`. We parse this `Location` using the `parseLocation` function we created before. Then we store this initial __route__ in our model.

### main

`main` now uses `Navigation.program` instead of `Html.program`.  `Navigation.program` wraps `Html.program` but also triggers a message when the browser location changes. In our case this message will be `OnLocationChange`.
