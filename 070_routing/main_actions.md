# Main: Actions, Model and Update

> This tutorial has been upgraded from Hop 2.1 to Hop 3.0 on 20-03-2016, if you started the Routing chapter before that please review from the back to the beginning of the chapter.

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

## Main Model

The main application model needs to be change to include the routing model. Change __src/Models.elm__ to:

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
    
    ...
    
    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing
      in
        ( { model | routing = updatedRouting }, Effects.map RoutingAction fx )

    ...
```

Here we added `RoutingAction`. We follow the same pattern as before and send those actions to the `Routing` module and then replace `.routing` in our main model.