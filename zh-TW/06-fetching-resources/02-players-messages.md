> 本頁包含 Elm 0.18

# 玩家訊息

首先，建立用來擷取玩家的訊息。新增一個匯入及訊息到 __src/Players/Messages.elm__

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
```

`OnFetchAll` 當從伺服端取得回應時呼叫。附帶的 `Result` 可能會是 `Http.Error` 或者玩家列表。