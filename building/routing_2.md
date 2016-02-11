# Routing 2

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

## Main View

Our main application view needs to show different pages as we change the browser location. Change __src/View.elm__ to:

```elm
module View (..) where

import Html exposing (..)
import Dict
import Actions exposing (..)
import Models exposing (..)
import Routing
import Players.List
import Players.Edit


view : Signal.Address Action -> AppModel -> Html
view address model =
  let
    _ =
      Debug.log "model" model
  in
    div
      []
      [ page address model ]


page : Signal.Address Action -> AppModel -> Html.Html
page address model =
  case model.routing.view of
    Routing.PlayersView ->
      let
        viewModel =
          { players = model.players
          }
      in
        Players.List.view (Signal.forwardTo address PlayersAction) viewModel

    Routing.PlayerEditView ->
      let
        playerId =
          model.routing.routerPayload.params
            |> Dict.get "id"
            |> Maybe.withDefault ""

        maybePlayer =
          model.players
            |> List.filter (\player -> (toString player.id) == playerId)
            |> List.head
      in
        case maybePlayer of
          Just player ->
            let
              viewModel =
                { player = player
                }
            in
              Players.Edit.view (Signal.forwardTo address PlayersAction) viewModel

          Nothing ->
            notFoundView

    Routing.NotFoundView ->
      notFoundView


notFoundView : Html.Html
notFoundView =
  div
    []
    [ text "Not found"
    ]
```

- Now we have a function `page` which has a case expression to show the correct view dependending on what is in `model.routing.view`.
- When hitting the edit player view (e.g. `/players/3/edit`) we may or may not have a player with that id. 
    -  We get the `id` from `model.routing.routerPayload.params`.
    -  Then we filter the `model.players` collection to find that id.
    -  Then we add a case expression that either shows the edit view or a 'not found view' if the player is not found.


