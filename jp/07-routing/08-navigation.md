>このページでは、Elm 0.17

# ナビゲーション

次に、ビュー間を移動するためのボタンを追加しましょう。

## EditPlayerメッセージ

__src/Players/Messages.elm__に2つの新しいアクションを追加するように変更してください：

```elm
...

type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | ShowPlayers
    | ShowPlayer PlayerId
```

`ShowPlayers`と`ShowPlayer`を追加しました。

## プレーヤーリスト

プレイヤーのリストは、各プレイヤーが `ShowPlayer`メッセージをトリガーするためのボタンを表示する必要があります。

まず、__src/Players/List.elm__に`Html.Events`を追加してください：

```elm
import Html.Events exposing (onClick)
```

このボタンの最後に新しい機能を追加します：

```elm
editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

ここでは、編集したいプレイヤーのIDで `ShowPlayer`をトリガーします。

そして、このボタンを含むように `playerRow`を変更してください：

```elm
playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player ]
        ]
```

## プレイヤー編集

編集ビューにナビゲーションボタンを追加しましょう。 __/src/Players/Edit.elm__で：

1つ以上のインポートを追加します：

```elm
import Html.Events exposing (onClick)
```

リストボタンの最後に新しい関数を追加します：

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

ここでは、ボタンをクリックすると `ShowPlayers`を送ります。

そしてこのボタンをリストに追加し、 `nav`関数を以下のように変更します：

```elm
nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```

## プレーヤーの更新

最後に、__src/Players/Update.elm__は新しいメッセージに応答する必要があります。

```elm
import Navigation
```

そして、2つの新しい枝をcase式に追加します。

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ (toString id)) )
```

`Navigation.newUrl`はコマンドを返します。 Elmがこのコマンドを実行すると、ブラウザの閲覧ロケーションが変わります。

## テストする

`http://localhost:3000/#players`のリストに行きます。編集ボタンが表示されます。クリックすると、その場所が編集ビューに変わります。
