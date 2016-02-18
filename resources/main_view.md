# Main View

And modify __src/View.elm__ so we see the list of players:

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

The application should look like <https://github.com/sporto/elm-tutorial-app/tree/100-players>
