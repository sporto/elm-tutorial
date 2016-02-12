# Main view


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

Now we have a function `page` which has a case expression to show the correct view dependending on what is in `model.routing.view`.

When hitting the edit player view (e.g. `/players/3/edit`) we may or may not have a player with that id. 
    
-  We get the `id` from `model.routing.routerPayload.params`.
-  Then we filter the `model.players` collection to find that id.
-  Then we add a case expression that either shows the edit view or a 'not found view' if the player is not found.

