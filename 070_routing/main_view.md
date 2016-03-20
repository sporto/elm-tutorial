# Main view


Our main application view needs to show different pages as we change the browser location. Change __src/View.elm__ to:

<https://github.com/sporto/elm-tutorial-app/blob/060-routing/src/View.elm>

```elm
module View (..) where

import Html exposing (..)
import Actions exposing (..)
import Models exposing (..)
import Routing
import Players.List
import Players.Edit
import Players.Models exposing (PlayerId)


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
  case model.routing.route of
    Routing.PlayersRoute ->
      playersPage address model

    Routing.PlayerEditRoute playerId ->
      playerEditPage address model playerId

    Routing.NotFoundRoute ->
      notFoundView


playersPage : Signal.Address Action -> AppModel -> Html.Html
playersPage address model =
  let
    viewModel =
      { players = model.players
      }
  in
    Players.List.view (Signal.forwardTo address PlayersAction) viewModel


playerEditPage : Signal.Address Action -> AppModel -> PlayerId -> Html.Html
playerEditPage address model playerId =
  let
    maybePlayer =
      model.players
        |> List.filter (\player -> player.id == playerId)
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


notFoundView : Html.Html
notFoundView =
  div
    []
    [ text "Not found"
    ]

```

---

Note these lines in `view`:

```elm
import Debug
...

view address model =
  let
    _ =
      Debug.log "model" model
  in
    ..
```

This is a handy trick for printing the current model to the console, very useful for debugging our application while developing.

---

Now we have a function `page` which has a case expression to show the correct view depending on what is in `model.routing.route`.



When hitting the edit player view (e.g. `/players/3/edit`) we may or may not have a player with that id.
    
-  We get the `id` from `model.routing.routerPayload.params`.
-  Then we filter the `model.players` collection to find that id.
-  Then we add a case expression that either shows the edit view or a 'not found view' if the player is not found.

