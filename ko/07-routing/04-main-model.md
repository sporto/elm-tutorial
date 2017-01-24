> This page covers Elm 0.18

# 메인 모델

현재 루트를 메인 어플리케이션 모델에 저장할 겁니다.
__src/Models.elm__ 을 변경합니다:

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

여기서는:

- `route` 를 모델에 추가했습니다.
- `initialModel` 이 `route` 를 받도록 했습니다.
