>このページでは、Elm 0.17

# メインビュー

__src/View.elm__を変更して、プレーヤーのリストを追加します：

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.List


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    Html.App.map PlayersMsg (Players.List.view model.players)
```
