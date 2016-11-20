>このページでは、Elm 0.17

# ルーティング

アプリケーションのルーティング設定を定義するモジュール__src/Routing.elm__を作成します。

このモジュールでは以下を定義します：

- アプリケーションのルート
- パスマッチャーを使用してブラウザパスをルートにマッチさせる方法
- ルーティングメッセージに反応する方法

__src/Routing.elm__では：

```elm
module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Players.Models exposing (PlayerId)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
```

---

このモジュールを見てみましょう。

### ルート

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

これらはアプリケーションで利用可能なルートです。
`NotFound`は、ブラウザパスと一致するルートがない場合に使用されます。

### マッチャー

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]
```

ここではルートマッチャーを定義します。これらのパーサは、url-parserライブラリによって提供されます。

3つのマッチャーが必要です：

- `PlayersRoute`に解決される空のルートのもの
- `PlayersRoute`にも解決される`/players`のためのもの
- `PlayerRoute id`に解決される`/players/id`のためのもの

順序は重要であることに注意してください。

このライブラリの詳細はこちらをご覧ください<http://package.elm-lang.org/packages/evancz/url-parser>。

### ハッシュパーサー

```elm
hashParser : Navigation.Location -> Result String Route
hashParser location ➊ =
    location.hash ➋
        |> String.dropLeft 1 ➌
        |> parse identity matchers ➍
```

ブラウザ閲覧ロケーションが変更されるたびに、ナビゲーションライブラリは私たちに `Navigation.Location`レコードを与えます。

`hashParser`は以下のような関数です：

- この「Navigation.Location」レコードを取得する➊
- それの `.hash`部分を抽出します➋
- 最初の文字を削除します(`#`)➌
- 定義されたマッチャーでこの文字列を `parse`に送ります➍

このパーサーは `Result`値を返します。成功すると、一致した `Route`が得られます。それ以外の場合は、文字列としてエラーが発生します。

### パーサー

```elm
parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser
```

ナビゲーションパッケージでは、現在の場所のパーサが必要です。ブラウザが閲覧しているロケーションが変更されるたびに、Navigationがこのパーサーを呼び出します。 `hashParser`を`Navigation.makeParser`に渡します。

### 結果を経路指定する

```elm
routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute

```

最後に、パーサから結果を取得するときに、ルートを抽出します。すべてのマッチャーが失敗した場合、代わりに `NotFoundRoute`を返します。
