> 本頁包含 Elm 0.18

# 主視界（Main view）

當更改網址時，主視界需要顯示不同的頁面。

更改 __src/View.elm__ 成：

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

### 顯示正確視界

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

現在有個 `page` 函式，裡面有 case 表達式，用來根據 `model.route` 的內容來決定要顯示正確的視界。

當有玩家編輯路由符合時（如 `#players/2`），從路由取得玩家 id，例如 `PlayerRoute playerId`。

### 尋找玩家

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

現在有了 `playerId`，但可能實際上沒有此 id 的玩家紀錄。使用 id 來過濾玩家列表，根據玩家存在與否，使用 case 表達式顯示正確的視界。

### notFoundView

當沒有符合路由時會顯示 `notFoundView` 。請注意型別是 `Html msg` 而非 `Html Msg`。這是因為此視界不會產生任何訊息，所以可以使用泛用型別變數 `msg` 取代特定型別 `Msg`。