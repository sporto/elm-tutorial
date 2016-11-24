> This page covers Elm 0.18


# メインアップデート

新規の`OnLocationChange`メッセージを処理するMainの`update`関数です。

__src/Update.elm__に新しい分岐の枝を追加します:

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

ここで、`OnLocationChange`メッセージを受け取ると、このlocationをパースし、一致したルートをモデルに格納します。
