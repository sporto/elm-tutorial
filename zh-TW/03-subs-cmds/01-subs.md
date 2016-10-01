# 訂閱（Subscriptions）

Elm 中，使用__訂閱__來監聽外部輸入。例如：

- [鍵盤事件](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- [滑鼠活動](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- 瀏覽器的網址更動
- [Websocket 事件](http://package.elm-lang.org/packages/elm-lang/websocket/latest/WebSocket)

讓我們建置一個應用程式來描繪如何回應鍵盤及滑鼠事件。

首先，安裝必要函式庫

```bash
elm package install elm-lang/mouse
elm package install elm-lang/keyboard
```

接著建立程式

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Mouse
import Keyboard


-- 模型


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- 訊息


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- 視界


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )



-- 訂閱


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.presses KeyMsg
        ]



-- 主程式


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

使用 Elm reactor 執行此程式，每當你按下滑鼠，計數器會加一，每當你按下鍵盤按鍵，計數器會加二。

---

讓我們回顧這程式中與訂閱相關的重要部份。

### 訊息

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

我們兩個訊息 `MouseMsg` 及 `KeyMsg`。當滑鼠按下或鍵盤按下時會觸發。

### 更新

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )
```

更新程式對於各訊息反應不同，當按下滑鼠計數器加一，按下鍵盤計數器加二。

### 訂閱

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.presses KeyMsg ➋
        ]
```

這裡宣告了我們希望監聽的事件。我們希望監聽 `Mouse.clicks` ➊ 以及 `Keyboard.presses` ➋。兩者函式都是接受訊息建構子（message constructor），傳回訂閱。

我們使用 `Sub.batch` ➌ 來同時監聽兩件事。Batch 接受訂閱串列，傳回一個訂閱，此訂閱包含所有的訂閱。
