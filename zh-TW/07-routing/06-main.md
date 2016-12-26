# 主程式

最後，需要把所有東西裝到主要模組。

更改 __src/Main.elm__ 成：

```elm
module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
```

---

### 新增匯入

匯入 `Navigation` 及 `Routing`。

### 初始

```elm
init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

init 函式現在從 `parser` 取得初始結果，存入 `Routing`。剖析器輸出是個 `Result`。__Navigation__ 模組會負責剖析初始位置並傳遞結果至 `init`。儲存初始__路由__於模型。

### urlUpdate

每當瀏覽器網址更改時，__Navigation__ 會呼叫 `urlUpdate`。如同 `init`，這裡從剖析器取得結果。這裡所做的事都會有一個新的__路由__。

### main

`main` 現在改用 `Navigation.program` 而不是 `Html.App.program`。`Navigation.program` 包裝 Html.App，額外加入 `urlUpdate` 供瀏覽器網址更改時呼叫。
