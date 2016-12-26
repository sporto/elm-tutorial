# 路由

新增 __src/Routing.elm__ 模組，用來定義應用程式的路由設置。

此模組定義：

- 應用程式的路由
- 多少個路徑比對
- 如何反應路由訊息

__src/Routing.elm__ 檔案：

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

仔細檢查這個模組。

### 路由

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

這些是應用程式內可用的路由。
當沒有任何符合的路徑，使用 `NotFound。

### 比對器

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]
```

這是比對器。由 url-parser 函式庫提供剖析器。

想要三個比對：

- 空的路由解析成 `PlayersRoute`
- 單一 `/players` 路徑解析成 `PlayersRoute`
- 任意 `/players/id` 路徑解析成 `PlayerRoute id`

注意到順序很重要。

更多詳細細節請見 <http://package.elm-lang.org/packages/evancz/url-parser>。

### Hash 剖析器

```elm
hashParser : Navigation.Location -> Result String Route
hashParser location ➊ =
    location.hash ➋
        |> String.dropLeft 1 ➌
        |> parse identity matchers ➍
```

每當瀏覽器網址更動時，Navigation 函式庫會給予 `Navigation.Location` 紀錄。

`hashParser` 函式則是：

- 取用 `Navigation.Location` 紀錄 ➊
- 取出 `.hash` 的部份 ➋
- 移除第一個字元（`#`）
- 將字串及比對器送到 `parse` ➍

parser 傳回 `Result` 值。當剖析成功得到符合的 `Route`，失敗得到錯誤訊息字串。

### 剖析器

```elm
parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser
```

Navigation 預期一個目前位置的剖析器，每當位置更動時，Navigation 會呼叫此剖析器。傳遞 `hashParser` 至 `Navigation.makeParser`。

### 路由結果

```elm
routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
```

最後，當剖析器取得結果，希望取出路由。如果沒有符合，則傳回 `NotFoundRoute`。
