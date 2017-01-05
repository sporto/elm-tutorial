> 本頁包含 Elm 0.18

# 主更新（Main update）

需要讓 `update` 函式回應 `OnLocationChange` 訊息。

在 __src/Update.elm__ 新增一個分支：

```elm
...
import Routing exposing (parseLocation)

...

update msg model =
    case msg of
        ...
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
```

當收到 `OnLocationChange` 訊息，剖析此路徑並儲存符合的路由於模型。