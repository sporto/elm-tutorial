# Main

Finally we need to wire everything in the Main module.

Change __src/Main.elm__ to:

```elm
module Main exposing (..)

import Html.App
import Navigation
import Hop.Types
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( initialModel location route, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
    ( { model | routing = Routing.Model location route }, Cmd.none )



-- MAIN


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

We added imports for `Navigation`, `Hop` and `Routing`.

### Init

```elm
init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( initialModel location route, Cmd.map PlayersMsg fetchAll )
```

Our init function will now take an initial output from the `parser` we added in `Routing`. The parser output is a tuple with (matched route, current location). The __Navigation__ module will take care of parsing the initial location and pass the result to `init`. We store this initial __route__ and __location__ in our model.

#### Why care about the location?

We will use the __route__ to show the relevant view, so it is clear why we should store this. But what about location?

If you application needs to do anything with query strings then the __location__ record will be useful for fetching the current query string information.

### urlUpdate

`urlUpdate` will be called by the __Navigation__ package each time the location in the browser changes. Just like in `init`, here we get the result of our parser. All we do here is store the new __route__ and __location__ in our application model.

### main

`main` now uses `Navigation.program` instead of `Html.App.program`.  `Navigation.program` wraps Html.App but adds a `urlUpdate` callback for when the browser location changes.
