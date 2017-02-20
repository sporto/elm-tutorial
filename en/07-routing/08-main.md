> This page covers Tutorial v2. Elm 0.18.

# Main

Finally we need to wire everything in the Main module.

Change __src/Main.elm__ to:

```elm
module Main exposing (..)

import Commands exposing (fetchPlayers)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, fetchPlayers )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
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
        ( initialModel currentRoute, fetchPlayers )
```

Our init function will now take an initial `Location` from the `Navigation` package. We parse this `Location` using the `parseLocation` function we created before. Then we store this initial __route__ in our model.

### main

`main` now uses `Navigation.program` instead of `Html.program`.  `Navigation.program` wraps `Html.program` but also triggers a message when the browser location changes. In our case this message will be `OnLocationChange`.
