# Player Edit: Actions, Model and Update


-- MOVE TO NAVIGATION

## Players Update

Players Update need to respond to `EditPlayer`. Change __src/Players/Update.elm__ to:

```elm
module Players.Update (..) where

import Hop
import Effects exposing (Effects)
import Players.Actions exposing (..)
import Players.Models exposing (..)


type alias UpdateModel =
  { players : List Player
  }


update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
  case action of
    EditPlayer id ->
      let
        path =
          "/players/" ++ (toString id) ++ "/edit"
      in
        ( model.players, Effects.map HopAction (Hop.navigateTo path) )

    HopAction payload ->
      ( model.players, Effects.none )

    NoOp ->
      ( model.players, Effects.none )
```



MOVE TO NAVIGATION
## Players Actions

We need a new Players action to trigger a location change to the player edit view. Change __src/Players/Actions.elm__ to:

```elm
module Players.Actions (..) where

import Hop
import Players.Models exposing (PlayerId, Player)


type Action
  = NoOp
  | EditPlayer PlayerId
  | HopAction Hop.Action
```

We will trigger `EditPlayer` whenever we want to edit a player.