> 本頁包含 Elm 0.18

# 玩家命令（Commands）

接下來，新增任務及命令，透過 API 儲存更新後玩家。

位於 __src/Players/Commands.elm__ 檔案：

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

### 儲存任務

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

➊ 編譯給定的玩家，轉換編碼過的值成一個 JSON 字串。
➋ 指出如何剖析回應，這個範例希望剖析傳回的 JSON 成 Elm 的值。
➌ `PATCH` 是個 http 方法，預期在更新紀錄時呼叫的 API。

### 儲存

```elm
save : Player -> Cmd Msg
save player =
    saveRequest player ➊
        |> Http.send OnSave ➋
```

新增儲存請求 ➊ 並且產生命令使用 `Http.send` ➋ 來發送請求。
`Http.send` 取得訊息建構子（此例的 `OnSave`）。當請求完成之後，Elm 將會觸發 `OnSave` 訊息並附帶請求的回應。