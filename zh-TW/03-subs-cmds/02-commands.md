# 命令（Commands）

Elm 中，命令（Cmd）是用來告訴執行期（runtime）如何執行有副作用（side effects）的事情。例如：

- 產生壹組亂數
- 發送 http 請求
- 儲存某些東西到 local storage

`Cmd` 可以是壹或多個要做的事情。使用命令聚集所有要發生的事情並交給執行期。接著執行期將會執行並將結果回給應用程式。

換句話說，如同 Elm，函數式語言的函式會傳回某個值。傳統的語言設計思維中，函式是禁止產生副作用的，Elm 採用一種非傳統的方式來模塑（modeling）它。本質上，函式傳回壹個命令值（command value），給予期望作用的名稱。由於 Elm 的架構，主要的 Html.App 程式，是命令值最終的收件人。Html.App 程式的更新函式，包含了如何執行該名稱命令的邏輯。

讓我們用個範例來試命令：

```elm
module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App
import Random


-- 模型


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )



-- 訊息


type Msg
    = Roll
    | OnResult Int



-- 視界


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Roll ] [ text "Roll" ]
        , text (toString model)
        ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate OnResult (Random.int 1 6) )

        OnResult res ->
            ( res, Cmd.none )



-- 主程式


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
```

如果執行此應用程式，會顯示壹個按鈕，當你點擊後產生壹個亂數。

---

回顧相關的部份：

### 訊息

```elm
type Msg
    = Roll
    | OnResult Int
```

應用程式有兩個訊息。`Roll` 表示骰出新的亂數。`OnResult` 表示從 `Random` 函式庫取得生產結果。

### 更新

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate➊ OnResult (Random.int 1 6) )

        OnResult res ->
            ( res, Cmd.none )
```

➊ `Random.generate` 產生壹個命令，此命令將產生壹個亂數。函式的第壹個參數必須是訊息建構子，用來提供結果給應用程式。此例中的建構子為 `OnResult`。

所以，當命令執行，Elm 呼叫 `OnResult` 伴隨著生產出來的數字，例如 `OnResult 2`。接著 __Html.App__ 將此訊息回給應用程式。

如果你感到疑惑，`OnResult res` 表示壹種訊息，OnResult 裝載了額外的訊息，就如此例中的整數 'res'。這種樣式也就是所謂的參數化型別（parameterized types）。

---

大型應用程式中常有許多巢狀元件，很有可能一次送出許多命令到 __Html.App__。以下列圖例為例：

![Flow](02-commands.png)

這裡從三個不同階層收集命令。最後將發送這所有命令到 __Elm.App__ 執行。
