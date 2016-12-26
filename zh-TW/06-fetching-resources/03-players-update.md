# 玩家更新

當請求玩家完成，觸發 `FetchAllDone` 訊息。

__src/Players/Update.elm__ 必須處理這個訊息。更改 `update` 成：

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )
```

`FetchAllDone` 擷取到的玩家，將裝載訊息更新到玩家集合。

`FetchAllFail` 錯誤發生。目前只是傳回與先前相同的東西。
