# Main: Actions, Model and Update

## Main Model

The main application model needs to be change to include the routing model. Change __src/Model.elm__ to:

```elm
module Models (..) where

import Players.Models exposing (Player)
import Routing


type alias AppModel =
  { players : List Player
  , routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  { players = [ Player 1 "Sam" 1 ]
  , routing = Routing.initialModel
  }
```

## Main Actions

In __src/Actions.elm__ we need to add a new action so we can route actions coming from the router:

```elm
module Actions (..) where

import Players.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | PlayersAction Players.Actions.Action
```

## Main Update

__src/Update.elm__ also needs to account for the newly added action:

```elm
module Update (..) where

import Effects exposing (Effects)
import Debug
import Models exposing (..)
import Actions exposing (..)
import Routing
import Players.Update


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case (Debug.log "action" action) of
    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing
      in
        ( { model | routing = updatedRouting }, Effects.map RoutingAction fx )

    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players
          }

        ( updatedPlayers, fx ) =
          Players.Update.update subAction updateModel
      in
        ( { model | players = updatedPlayers }, Effects.map PlayersAction fx )

    NoOp ->
      ( model, Effects.none )
```

Here we added `RoutingAction`. We follow the same pattern as before and send those actions to the `Routing` module and then replace `.routing` in our main model.