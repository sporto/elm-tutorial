> 本頁包含 Elm 0.18

# 訂閱（Subscriptions）

Elm 中，使用__訂閱__來監聽外部輸入。例如：

- [鍵盤事件](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- [滑鼠活動](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- 瀏覽器網址的更動
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

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

使用 Elm reactor 執行此程式，每當你按下滑鼠，計數器會加壹，每當你按下鍵盤按鍵，計數器會加貳。

---

回顧這程式的重要部份，與訂閱有關。

### 訊息

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

兩個合適的訊息 `MouseMsg` 及 `KeyMsg`。當按下滑鼠或鍵盤時觸發。

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

對於各訊息，更新程式的反應不同，當按下滑鼠計數器加壹，按下鍵盤計數器加貳。

### 訂閱

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.downs KeyMsg ➋
        ]
```

這裡宣告希望監聽的事件。監聽 `Mouse.clicks` ➊ 以及 `Keyboard.presses` ➋。兩者函式都是接受訊息建構子（message constructor）傳回訂閱。

使用 `Sub.batch` ➌ 同時監聽兩個事件。Batch 接受訂閱串列，傳回壹個訂閱，包含所有的訂閱。
