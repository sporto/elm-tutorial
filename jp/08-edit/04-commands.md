>このページでは、Elm 0.17

# Playersコマンド

次に、更新されたプレーヤーをAPIで保存するタスクとコマンドを作成しましょう。

__src/Players/Commands.elm__に追加します：

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ (toString playerId)


saveTask : Player -> Task.Task Http.Error Player
saveTask player =
    let
        body =
            memberEncoded player
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl player.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson memberDecoder


save : Player -> Cmd Msg
save player =
    saveTask player
        |> Task.perform SaveFail SaveSuccess


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.int player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### タスクを保存する

```elm
saveTask : Player -> Task.Task Http.Error Player
saveTask player =
    let
        body =
            memberEncoded player ➊
                |> Encode.encode 0 ➋
                |> Http.string ➌

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl player.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config ➍
            |> Http.fromJson memberDecoder ➎
```

➊指定されたプレーヤーをエンコードし、レコードを「Value」に変換します。ここで「Value」は、JavaScriptの値(数値、文字列、null、ブール値、配列、オブジェクト)をカプセル化する型です。

➋ `Encode.encode`は`Value`をJson文字列に変換します。
JavaScriptの `JSON.stringify`に似ています。 `0`は返却する文字列中での字下げを示します。
<http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Json-Encode#encode>

➌指定された文字列を使用してHttpリクエスト本体を作成します。 <http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#string>

➍エンコードされたプレーヤーをAPIに送信するタスクを作成します。
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#send>

これは前のタスクを引き継ぎ、APIによって与えられた応答をデコードし、デコードされた値を与える新しいタスクでそれを連鎖させます。
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#fromJson>

### 保存

```elm
save : Player -> Cmd Msg
save player =
    saveTask player ➊
        |> Task.perform ➋ SaveFail SaveSuccess
```

`saveTask`を実行し、`Task.perform`を使用してコマンドに変換します。このコマンドは失敗時には `SaveFail`メッセージ、成功時には`SaveSuccess`メッセージで解決されます。
