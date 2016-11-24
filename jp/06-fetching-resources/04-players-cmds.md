>このページでは、Elm 0.18

# Playersコマンド

サーバーからプレーヤーを取得するためのタスクとコマンドを作成する必要があります。 __src/Players/Commands.elm__を作成します。

```elm
module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```
---

このコードを見てみましょう。

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll
```

ここでは、アプリケーションを実行するためのコマンドを作成します。

- `Http.get`が`Request`を作成します
- 次に、このrequestを`Http.send`に送ります。このタスクはコマンドでラップします

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

このデコーダは、リストの各メンバーのデコードを `memberDecoder`に委譲します

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```

`memberDecoder`は`Player`レコードを返すJSONデコーダを作成します。

---
デコーダーの仕組みを理解するために、Elm replを使って遊んでみましょう。

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
> idDecoder = (field "id" int)
```

これは、文字列が `id`キーを抽出してそれを整数としてパースするデコーダを作成します。

このデコーダを実行すると結果が表示されます。

```bash
> result = decodeString idDecoder json
OK 99：Result.Result String Int
```

`Ok 99`はデコードが成功し、99が得られたことを意味しています。これは`(field "id" Decode.int)`がやったことであり、単一のキーのデコーダを作成します。

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
> nameDecoder = (field "name" string)
> playerDecoder = map2 Player idDecoder nameDecoder
```

`map2`は最初の引数(この場合Player)と2つのデコーダとしての関数をとります。次に、デコーダを実行し、その結果を関数の引数(Player)に渡します。

試してみましょう：
```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

__program__にコマンドを送信するまで、実際には実行されません。
