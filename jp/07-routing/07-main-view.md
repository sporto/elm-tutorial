>このページでは、Elm 0.18

# メインビュー

主なアプリケーションビューでは、ブラウザの場所を変更するときに別のページを表示する必要があります。

__src/View.elm__を次のように変更します。

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

### 正しいビューを表示

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

これで、 `model.route`に応じた正しいビューを表示するためのcase式を持つ`page`関数が定義できました。

プレーヤーの編集ルートが一致すると(たとえば`#players/2`)、ルートからプレーヤーID、つまり「PlayerRoute playerId」を取得できます。

### プレーヤーを探す

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

`playerId`を取得できましたが、そのidに対応する実際のプレイヤーレコードを持っていないかもしれません。なのでプレーヤーのリストをIDでフィルタリングし、プレーヤーが見つかったかどうかに応じて正しいビューを表示するcase式を定義します。

### notFoundView

`notFoundView`は経路が一致しないときに表示されます。 `Html Msg`ではなく`Html msg`の型に注目してください。これは、このビューはメッセージを生成しないため、特定の型`Msg`の代わりにジェネリック型変数`msg`を使用できるからです。
