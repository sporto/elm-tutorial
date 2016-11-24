>This page covers Elm 0.18

# ルーティング

アプリケーションのルーティング設定を定義するモジュール__src/Routing.elm__を作成します。

このモジュールでは以下を定義します：

- アプリケーションのルート
- パスマッチャーを使用してブラウザパスをルートにマッチさせる方法
- ルーティングメッセージに反応する方法

__src/Routing.elm__では：

```elm
module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
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
`NotFoundRoute`は、ブラウザパスと一致するルートがない場合に使用されます。

### マッチャー

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]
```

ここではルートマッチャーを定義します。これらのパーサは、url-parserライブラリによって提供されます。

3つのマッチャーが必要です：

- `PlayersRoute`に解決されるトップのルートのもの
- `PlayersRoute`にも解決される`/players`のためのもの
- `PlayerRoute id`に解決される`/players/id`のためのもの

順序は重要であることに注意してください。

このライブラリの詳細はこちらをご覧ください<http://package.elm-lang.org/packages/evancz/url-parser>。

### パースロケーション

```elm
parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

ブラウザ閲覧ロケーションが変わるたびに、ナビゲーション・ライブラリーは`Navigation.Location`レコードを含むメッセージをトリガーします。mainの `update`からこのレコードを引数として`parseLocation`を呼び出します。

`parseLocation`はこの`Location`レコードを解析し、可能ならば `Route`を返す関数です。すべてのマッチャーが失敗した場合は、`NotFoundRoute`を返します。

この場合、ハッシュを使用してルーティングするので、`UrlParser.parseHash`を実行します。代わりに `UrlParser.parsePath`を使ってパスを使ってルーティングすることもで
きます。
