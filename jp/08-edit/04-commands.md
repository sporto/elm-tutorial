>このページでは、Elm 0.18

# Playersコマンド

次に、プレーヤーをAPIで更新するコマンドを作成しましょう。

__src/Players/Commands.elm__に追加します：

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### リクエストを保存する

```elm
saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody ➊
        , expect = Http.expectJson memberDecoder ➋
        , headers = []
        , method = "PATCH" ➌
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }
```

➊ここで、指定されたプレーヤーをエンコードし、エンコードされた値をJSON文字列に変換します
➋ここでは、レスポンスをパースする方法を指定します。この場合、返されたJSONをパースし、Elmの値に戻す必要があります。
➌ `PATCH`はAPIがレコードを更新するときに期待するhttpメソッドです。

### 保存

```elm
save : Player -> Cmd Msg
save player =
    saveRequest player ➊
        |> Http.send OnSave ➋
```

ここでは、保存要求➊を作成し、 `Http.send`を使用して要求を送信するコマンドを生成します➋。
`Http.send`はメッセージコンストラクタ（この場合は` OnSave`）をとります。リクエストが完了すると、Elmはリクエストに対するレスポンスとともに `OnSave`メッセージをトリガします。
