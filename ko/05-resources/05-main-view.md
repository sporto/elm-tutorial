> This page covers Elm 0.18

# 메인 뷰

__src/View.elm__ 를 수정하여 플레이어 리스트를 추가합니다:

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

