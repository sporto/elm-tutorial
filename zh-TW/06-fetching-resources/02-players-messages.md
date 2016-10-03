# 玩家訊息（Players messages）

首先，建立用來擷取玩家的訊息。新增一個匯入及訊息到 __src/Players/Messages.elm__

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
```

`FetchAllDone` 當從伺服端取得回應後呼叫。訊息帶著擷取到的玩家列表。

`FetchAllFail` 如果擷取過程中有問題便會呼叫此函式。
