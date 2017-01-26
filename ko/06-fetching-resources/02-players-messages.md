> This page covers Elm 0.18

# 플레이어 메시지

플레이어 목록을 가져오는데 필요한 메시지부터 작성해 봅시다. __src/Players/Messages.elm__ 에 새로운 임포트와 메시지를 추가합니다.

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
```

서버로부터 응답을 받으면 `OnFetchAll` 메시지가 호출됩니다. 이는 `Http.Error` 또는 가져온 플레이어 목록을 담은 `Result` 를 포함하고 있습니다.
