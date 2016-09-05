# Main

Finally we need to wire everything in the Main module.

Change __src/Main.elm__ to:

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

### New imports

We added imports for `Navigation` and `Routing`.

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

Our init function will now take an initial output from the `parser` we added in `Routing`. The parser output is a `Result`. The __Navigation__ module will take care of parsing the initial location and pass the result to `init`. We store this initial __route__ in our model.

### urlUpdate

`urlUpdate` will be called by the __Navigation__ package each time the location in the browser changes. Just like in `init`, here we get the result of our parser. All we do here is store the new __route__ in our application model.

### main

`main` now uses `Navigation.program` instead of `Html.App.program`.  `Navigation.program` wraps Html.App but adds a `urlUpdate` callback for when the browser location changes.
