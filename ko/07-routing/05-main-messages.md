> This page covers Elm 0.18

# 메인 메시지

브라우저 경로가 바뀔 때 사용할 새 메시지가 필요합니다.

__src/Messages.elm__ 를 바꿉니다:

```elm
module Messages exposing (..)

import Navigation exposing (Location)
import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | OnLocationChange Location
```

- `Navigation` 을 임포트하고 있습니다.
- `OnLocationChange Location` 메시지를 추가했습니다.
