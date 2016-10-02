# 主視界（Main view）

修改 __src/View.elm__ 包含玩家列表：

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
