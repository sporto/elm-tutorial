> 本頁包含 Elm 0.18

# 主訊息（Main messages）

當瀏覽器網址改變時，觸發一個新訊息。

修改 __src/Messages.elm__ 成：

```elm
module Messages exposing (..)

import Navigation exposing (Location)
import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | OnLocationChange Location
```

- 現在引入 `Navigation`
- 接著新增 `OnLocationChange Location` 訊息