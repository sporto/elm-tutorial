# Main

The main level needs to be hooked up with the Players modules we created.

We need to create links from:

```
Main Actions   --->    Players Actions
Main Models    --->    Players Models
Main Update    --->    Main Update
```

## Main Actions

Modify __src/Actions.elm__ to include players actions:

```elm
module Actions (..) where

import Players.Actions

type Action
  = NoOp
  | PlayersAction Players.Actions.Action
```

## Main Models

Modify __src/Models.elm__ to include players:

```elm
module Models (..) where

import Players.Models exposing (Player)


type alias AppModel =
  { players : List Player
  }


initialModel : AppModel
initialModel =
  { players = [ Player 1 "Sam" 1 ]
  }
```

Here we have a hardcoded player for now.

## Main Update

Change __src/Update.elm__ to:

```elm
module Update (..) where

import Effects exposing (Effects)
import Models exposing (..)
import Actions exposing (..)
import Players.Update


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case action of
    PlayersAction subAction>
      let
        updateModel =
          { players = model.players
          }

        ( updatedPlayers, fx ) =
          Players.Update.update subAction updateModel
      in
        ( { model | players = updatedPlayers }, Effects.map PlayersAction fx )

    NoOp>
      ( model, Effects.none )
```

Here we follow the Elm architecture, all `PlayersAction` are routed to `Players.Update`.

