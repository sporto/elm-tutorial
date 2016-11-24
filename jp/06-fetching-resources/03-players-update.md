>このページでは、Elm 0.18

# プレーヤーの更新

プレーヤーのリクエストが完了すると、 `OnFetchAll`メッセージがトリガーされます。

__src/Players/Update.elm__は、この新しいメッセージに責任を持つ必要があります。 `update`を以下のように変更してください：

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

`OnFetchAll`というメッセージを得たとき、何を実行するかを決定するためにパターンマッチングを使用できます。

- `Ok`の場合、取得されたプレーヤーを返して、プレーヤーのコレクションを更新します。
- `Err`の場合、私たちは今までに持っていたものを返すだけです（もっと良いのはユーザーにエラーを表示することですが、チュートリアルを簡単にするために省略します)。
