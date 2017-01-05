> 本頁包含 Elm 0.18

# 路由

新增 __src/Routing.elm__ 模組，用來定義應用程式的路由設置。

此模組定義：

- 應用程式的路由
- 使用路徑比對來決定如何比對路徑
- 如何反應路由訊息

__src/Routing.elm__ 檔案：

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

回顧這個模組。

### 路由

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

這些是應用程式內可用的路由。
當沒有任何符合路徑時使用 `NotFound。

### 比對器

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]
```

這是比對器。由 url-parser 函式庫提供剖析器。

想要三個比對：

- 最上方的路由解析成 `PlayersRoute`
- 單一 `/players` 路徑解析成 `PlayersRoute`
- 任意 `/players/id` 路徑解析成 `PlayerRoute id`

注意到順序很重要。

更多詳情細節請見 <http://package.elm-lang.org/packages/evancz/url-parser>。

### parseLocation

```elm
parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

每當瀏覽器網址更動時，Navigation 函式庫會觸發一個訊息，裡面包含  `Navigation.Location` 紀錄。從我們的 `update` 函式呼叫 `parseLocation` 並使用此紀錄。

`parseLocation` 函式剖析 `Location` 紀錄並傳回符合 `Route`。如果所有比對都失敗了，傳回 `NotFoundRoute`。

這個範例中 `UrlParser.parseHash` 使用 hash 來進行路由。你也可以使用 `UrlParser.parsePath` 取而代之。
