> 本頁包含 Elm 0.18

## 玩家編輯（Player edit）視界

新增 `ChangeLevel` 訊息。從玩家編輯視界觸發這個訊息。

編輯 __src/Players/Edit.elm__ 檔案，修改 `btnLevelDecrease` 及 `btnLevelIncrease`：

```elm
...
btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]
```

在這兩個按鈕新增 `onClick (ChangeLevel player.id howMuch)`。其中 `howMuch` 為 `-1` 來遞減等級，`1` 則是遞增。
