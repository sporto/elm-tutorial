> 本頁包含 Elm 0.18

# 主程式

最終將所有東西寫在主模組。

修改 __src/Main.elm__ 成：

```elm
module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

---

### 新增引入

新增引入 `Navigation` 及 `Routing`。

### 初始

```elm
init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

初始程式將從 `Navigation` 取得初始 `Location` 。使用先前新增的 `parseLocation` 剖析 `Location`。接著儲存初始__路由__於模型。

### 主程式

`main` 使用 `Navigation.program` 而非 `Html.program`。`Navigation.program` 包裝 `Html.program` 並且當瀏覽器網址更改時觸發一個訊息。本範例中這個訊息為 `OnLocationChange`。