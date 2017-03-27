> Cette page couvre Elm 0.18

# Vue Main

Modifiez __src/View.elm__ pour inclure la liste des joueurs :

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.List


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    Html.map PlayersMsg (Players.List.view model.players)
```
