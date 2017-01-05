> 本頁包含 Elm 0.18

# Navigation

接下來增加按鈕來切換不同視界。

## 玩家編輯訊息

修改 __src/Players/Messages.elm__ 新增兩個新按鈕：

```elm
...

type Msg
    = OnFetchAll (Result Http.Error (List Player))
    | ShowPlayers
    | ShowPlayer PlayerId
```

新增 `ShowPlayers` 及 `ShowPlayer`。

## 玩家列表

玩家列表需要為每個玩家顯示一個按鈕，用來觸發 `ShowPlayer` 訊息。
 
在 __src/Players/List.elm__。首先新增 `Html.Events`：

```elm
import Html.Events exposing (onClick)
```

最後為此按鈕新增一個函式：

```elm
editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

這裡觸發 `ShowPlayer` 帶著玩家 id。

並且修改 `playerRow` 引入這個按鈕：

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

## 玩家編輯

接下來新增導覽按鈕連結到編輯視界。在 __/src/Players/Edit.elm__：

再加入一個引入：

```elm
import Html.Events exposing (onClick)
```

最後為此加入一個新函式：

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

當點下按鈕時，發送 `ShowPlayers`。

接著新增按鈕到列表，修改 `nav` 函式：

```elm
nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```

## 玩家更新

最後，__src/Players/Update.elm__ 需要回應新的訊息。

```elm
import Navigation
```

新增兩個分支到 case 表達式：

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        ...

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ id) )
```

`Navigation.newUrl` 傳回一個命令。當 Elm 執行此命令，瀏覽器網址將會改變。

## 測試看看

前往列表 `http://localhost:3000/#players`。你會看到編輯按鈕，點下此按鈕，瀏覽器位置會換到編輯視界。

截至目前為止應用程式要看起來像是 <https://github.com/sporto/elm-tutorial-app/tree/018-07-navigation>.
