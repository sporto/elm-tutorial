# 玩家命令（Commands）

接下來，新增任務及命令，透過 API 儲存更新後玩家。

位於 __src/Players/Commands.elm__ 檔案：

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

### 儲存任務

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

➊ 編譯給定的玩家，轉換 record 成一個 `Value`。此文意中的 `Value` 指的一種型別，此型別封裝 JavaScript 的值（number、string、null、boolean、array、object）。

➋ `Encode.encode` 轉換 `Value` 成一個 Json 字串。
類似於 JavaScript 的 `JSON.stringify`。`0` 表示結果字串的縮排格數。
<http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Json-Encode#encode>

➌ 新增 Http 請求，使用給定字串產生內容。<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#string>

➍ 新增任務用來傳送編譯後的玩家至 API。
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#send>

➎ 這將前述任務串連上新的任務，新任務將會解譯給定 API 的傳回內容並給予將解譯後的值。
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#fromJson>

### 儲存

```elm
save : Player -> Cmd Msg
save player =
    saveTask player ➊
        |> Task.perform ➋ SaveFail SaveSuccess
```

取得 `saveTask` ➊ 並使用 `Task.perform` ➋ 轉換成命令。此命令將會解析出 `SaveFail` 失敗訊息或 `SaveSuccess` 成功訊息。
