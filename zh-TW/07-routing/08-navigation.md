# 導覽（Navigation）

接著讓我們新增按鈕，用來切換不同視界。

## EditPlayer 訊息

修改 __src/Players/Messages.elm__ 檔案引入兩個動作：

```elm
...

type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | ShowPlayers
    | ShowPlayer PlayerId
```

新增 `ShowPlayers` 及 `ShowPlayer`。

## 玩家列表

玩家列表的每位玩家都需要一個按鈕，用來觸發 `ShowPlayer` 訊息。

位於 __src/Players/List.elm__ 檔案。新增 `Html.Events`：

```elm
import Html.Events exposing (onClick)
```

最底下給按鈕新增一個函式：

```elm
editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

這裡觸發 `ShowPlayer` 伴隨著希望進行編輯的玩家 id。

修改 `playerRow` 引入此按鈕：

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

新增導覽按鈕至編輯視界。位於 __/src/Players/Edit.elm__ 檔案：

再引入一個：

```elm
import Html.Events exposing (onClick)
```

最底下給按鈕新增一個函式：

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

當按鈕點擊後，送出 `ShowPlayers`。

接著新增此按鈕至列表，修改 `nav` 函式：

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

新增兩個分支：

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

`Navigation.newUrl` 傳回一個命令。當 Elm 執行此命令時，瀏覽器網址將會改變。

## 測試

前往列表 `http://localhost:3000/#players`。你會看到一個編輯按鈕，點擊按鈕網址會改變，切換到編輯視界。
