>このページでは、Elm 0.17

# プレーヤーの更新

プレーヤーのリクエストが完了すると、 `FetchAllDone`メッセージがトリガーされます。

__src/Players/Update.elm__は、この新しいメッセージに責任を持つ必要があります。 `update`を以下のように変更してください：

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

`FetchAllDone`というメッセージは取得したプレーヤーを含んでいるので、そのペイロードを返してプレイヤーコレクションを更新します。

`FetchAllFail`はエラーの場合にマッチします。 今のところ、以前と同様にリターンします。
