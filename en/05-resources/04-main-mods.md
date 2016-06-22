# Main

The main level needs to be hooked up with the Players modules we created.

We need to create links from:

```
Main Messages  --->    Players Messages
Main Models    --->    Players Models
Main Update    --->    Players Update
```

## Main Messages

Modify __src/Messages.elm__ to include players messages:

```elm
module Messages exposing (..)

import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
```

## Main Models

Modify __src/Models.elm__ to include players:

```elm
module Models exposing (..)

import Players.Models exposing (Player)


type alias Model =
    { players : List Player
    }


initialModel : Model
initialModel =
    { players = [ Player 1 "Sam" 1 ]
    }
```

Here we have a hardcoded player for now.

## Main Update

Change __src/Update.elm__ to:

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, cmd ) =
                    Players.Update.update subMsg model.players
            in
                ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
```

Here we follow the Elm architecture:

- All `PlayersMsg` are routed to `Players.Update`.
- We extract the result for `Players.Update` using pattern matching
- Return the model with the updated player list and any command that needs to run.
