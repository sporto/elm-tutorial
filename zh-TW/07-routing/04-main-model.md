> 本頁包含 Elm 0.18

# 主模型（Main model）

希望在主應用程式模型中儲存目前的路由。
更改 __src/Models.elm__ 成：

```elm
module Models exposing (..)

import Players.Models exposing (Player)
import Routing


type alias Model =
    { players : List Player
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { players = []
    , route = route
    }
```

這裡：

- 新增 `route` 到模型
- 更改 `initialModel` 取得一個 `route`
