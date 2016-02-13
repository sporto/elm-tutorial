# Main

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

## Main Actions

Modify __src/Actions.elm__ to include players actions:

```elm
module Actions (..) where

import Players.Actions

type Action
  = NoOp
  | PlayersAction Players.Actions.Action
```

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

## Main View

Also __src/View.elm__:

```elm
module View (..) where

import Html exposing (..)
import Actions exposing (..)
import Models exposing (..)
import Players.List


view : Signal.Address Action> AppModel> Html
view address model =
  div
    []
    [ page address model ]


page : Signal.Address Action -> AppModel -> Html.Html
page address model =
  let
    viewModel =
      { players = model.players
      }
  in
    Players.List.view (Signal.forwardTo address PlayersAction) viewModel
```

Here `view` calls `page`, this split will make more sense when we add a router.

Also note how we create the necessary `viewModel` to pass to `Players.List.view`.

---

When you run the application you should see a list with one user.

The application should look like <https://github.com/sporto/elm-tutorial-app/tree/0200-players>