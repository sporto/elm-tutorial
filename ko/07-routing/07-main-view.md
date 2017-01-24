> This page covers Elm 0.18

# 메인 뷰

메인 뷰에서는 브라우저 경로 별로 다른 페이지를 보여 줘야 합니다.

__src/View.elm__ 를 변경합니다:

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Edit
import Players.List
import Players.Models exposing (PlayerId)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.map PlayersMsg (Players.List.view model.players)

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let
        maybePlayer =
            model.players
                |> List.filter (\player -> player.id == playerId)
                |> List.head
    in
        case maybePlayer of
            Just player ->
                Html.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
```

---

### 루트에 해당되는 뷰 그리기

```elm
page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.map PlayersMsg (Players.List.view model.players)

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView
```

`model.route` 에 따라 적절한 뷰를 보여주는 case 분기를 가진 `page` 함수가 되었습니다.

플레이어 편집 루트인 경우 (예: `#players/2`) 루트의 패턴 매칭으로 플레이어 아이디를 가져옵니다. (`PlayerRoute playerId`)

### 플레이어 찾기

```elm
playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let
        maybePlayer =
            model.players
                |> List.filter (\player -> player.id == playerId)
                |> List.head
    in
        case maybePlayer of
            Just player ->
                Html.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView
```

`playerId` 를 받았지만 그 아이디에 해당하는 플레이어 레코드가 존재하지 않을 수도 있습니다. 플레이어 리스트를 해당 아이디로 필터링하여 존재하는지 존재하지 않는지에 따라 뷰를 분기합니다.

### notFoundView

`notFoundView` 는 매치되는 뷰가 없는 경우 사용됩니다. `Html Msg` 가 아닌 `Html msg` 가 사용된 것을 보세요. 이 뷰는 생성하는 메시지가 없으므로 특정한 타입인 `Msg` 가 아닌 범용적인 타입 변수 `msg` 를 사용한 것입니다.
