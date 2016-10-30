# 主視界（Main view）

當我們更改瀏覽器網址，主應用程式視界需要顯示不同的頁面。

更改 __src/View.elm__ 成：

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.List
import Players.Edit
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
            Html.App.map PlayersMsg (Players.List.view model.players)

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
                Html.App.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
```

---

### 顯示目前視界

```elm
page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.App.map PlayersMsg (Players.List.view model.players)

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView
```

現在，`page` 函式中 case 表達式根據 `model.route` 的值顯示正確的視界。

當玩家編輯路由符合（例如 `#players/2`），我們將從路由取得玩家 ID，即 `PlayerRoute playerId`。

### 找尋玩家

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
                Html.App.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView
```

有了 `playerId`，但是沒有此 id 的實際玩家紀錄。使用此 id 來過濾玩家列表，並使用 case 表達式來判斷是否有符合玩家，進而顯示正確的視界。
