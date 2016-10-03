# 玩家命令（Players commands）

現在新增任務及命令，用來從伺服端擷取玩家。新增 __src/Players/Commands.elm__：

```elm
module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)
```
---

讓我們一步步來看。

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone
```

這裡新增一個命令讓應用程式去執行。

- `Http.get` 新增一個任務
- 接著傳送任務到 `Task.perform`，將會包裝成命令

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

此解譯器代理解譯列表中每個成員成為 `memberDecoder`

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)
```

`memberDecoder` 建立一個 JSON 解譯器，傳回 `Player` 紀錄。

---
為了瞭解解譯器的運作，讓我們玩玩 elm repl。

終端機內執行 `elm repl`。匯入 Json.Decoder 模組：

```bash
> import Json.Decode exposing (..)
```

定義一個 Json 字串：

```bash
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

接著，定義一個解譯器來取出 `id`：

```bash
> idDecoder = ("id" := int)
```

這會新增一個解譯器，給定一個字串，試著取出 `id` 鍵的值並剖析成為整數。

執行解譯器看結果：

```bash
> result = decodeString idDecoder  json
Ok 99 : Result.Result String Int
```

看到 `Ok 99` 表示解譯已經成功，得到了 99。這就是 `("id" := Decode.int)` 做的事，為單一鍵建立解譯器。

這是其中一個問題。現在第二個問題，定義一個型別：

```bash
> type alias Player = { id: Int, name: String }
```

Elm 中可以新增紀錄可以像函式一般呼叫型別。例如，`Player 1 "Sam"` 新增一個玩家紀錄。注意到參數順序如同其他函式一般，有其意義。

試試：

```bash
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

根據這兩個概念，讓我們建立一個完整的解譯器：

```bash
> nameDecoder = ("name" := string)
> playerDecoder = object2 Player idDecoder nameDecoder
```

`object2` 取用函數作為第一個參數（這個案例為 Player）及兩個解譯器。接著執行解譯器並將結果作為參數帶到（Player）函式。

試試：
```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

記住，這些都不會執行，直到發送命令到 __Html.App__。
