>このページでは、Elm 0.17

# Playersコマンド

サーバーからプレーヤーを取得するためのタスクとコマンドを作成する必要があります。 __src/Players/Commands.elm__を作成します。

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

このコードを見てみましょう。

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone
```

ここでは、アプリケーションを実行するためのコマンドを作成します。

- `Http.get`がタスクを作成します
- 次に、このタスクを `Task.perform`に送ります。このタスクはコマンドでラップします

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

このデコーダは、リストの各メンバーのデコードを `memberDecoder`に委譲します

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)
```

`memberDecoder`は`Player`レコードを返すJSONデコーダを作成します。

---
デコーダーの仕組みを理解するために、elm replを使って遊んでみましょう。

ターミナルで `elm repl`を実行します。 Json.Decoderモジュールをインポートします。

```bash
> import Json.Decode exposing (..)
```

次に、Json文字列を定義します。

```bash
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

また、 `id`を抽出するデコーダを定義します。

```bash
> idDecoder = ("id" := int)
```

これは、文字列が `id`キーを抽出してそれを整数としてパースするデコーダを作成します。

このデコーダを実行すると結果が表示されます。

```bash
> result = decodeString idDecoder json
OK 99：Result.Result String Int
```

`Ok 99`はデコードが成功し、99が得られたことを意味しています。これは`("id" := Decode.int)`がやったことであり、単一のキーのデコーダを作成します。

これは方程式の一部です。つぎに2番目の部分をやってみましょう。まず型を定義してください：

```bash
> type alias Player = { id: Int, name: String }
```

Elmでは、レコード型のエイリアス型名を関数として呼び出すことでレコードを作成することができます。たとえば、`Player 1 "Sam"`はプレーヤーレコードを作成します。パラメータの順序は他の関数と同様に重要であることに注意してください。

次を試してみてください：

```bash
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

これらの2つのコンセプトで完全なデコーダを作成しましょう：

```bash
> nameDecoder = ("name" := string)
> playerDecoder = object2 Player idDecoder nameDecoder
```

`object2`は最初の引数(この場合Player)と2つのデコーダとしての関数をとります。次に、デコーダを実行し、その結果を関数の引数(Player)に渡します。

試してみましょう：
```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

__Html.App__にコマンドを送信するまで、実際には実行されません。
