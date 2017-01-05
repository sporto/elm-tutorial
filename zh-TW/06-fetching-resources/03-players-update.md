> 本頁包含 Elm 0.18

# 玩家更新

當請求玩家完成後，將會觸發 `OnFetchAll` 訊息。

__src/Players/Update.elm__ 處理這個新訊息。更改 `update` 成：

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        OnFetchAll (Err error) ->
            ( players, Cmd.none )
```

當收到 `OnFetchAll` 時使用樣式對應來決定要作什麼事。

- `Ok` 情況下傳回擷取到的玩家，用來更新玩家集合。
- `Err` 情況下傳回與先前相同的東西。（比較好的作法是顯示錯誤訊息給使用者，但為了此教學的簡單性，這裡暫時不會這樣處理）
