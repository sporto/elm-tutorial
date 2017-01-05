> 本頁包含 Elm 0.18

# 主程式

## 主模型

將 __src/Models.elm__ 檔案內，寫死的玩家清單刪除

```elm
initialModel : Model
initialModel =
    { players = []
    }
```

## 主程式

最後，希望應用程式啟動時執行 `fetchAll`。

更新 __src/Main.elm__：

```elm
...
import Messages exposing (Msg(..))
...
import Players.Commands exposing (fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map PlayersMsg fetchAll )
```

現在，當應用程式啟動時，`init` 傳回命令列表。
