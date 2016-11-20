>このページでは、Elm 0.17

# メインモデル

私たちのメインのアプリケーションモデルでは、現在のルートを保存します。
__src/Models.elm__を次のように変更します。

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

ここで我々は：

- モデルに `route`を追加しました
- `initialModel`を、引数`route`を取るように変更しました
