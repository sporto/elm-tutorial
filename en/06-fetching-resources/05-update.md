> This page covers Tutorial v2. Elm 0.18.

# Update

When the request for players is done, we trigger the `OnFetchPlayers` message.

__src/Update.elm__ should account for this new message. Change `update` to:

```elm
module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )
```

When we get `OnFetchPlayers` we get a response and store it `players`.
