>This page covers Elm 0.18

# サブスクリプション(購読)

Elmでは、__サブスクリプション__を使用すると、アプリケーションが外部入力を待ち受ける方法が決まります。いくつかの例があります：

- [キーボードイベント](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- [マウスの動き](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- ブラウザの閲覧ロケーションの変更
- [Websocketイベント](http://package.elm-lang.org/packages/elm-lang/websocket/latest/WebSocket)

これらを説明するために、キーボードイベントとマウスイベントの両方に応答するアプリケーションを作成しましょう。

まず必要なライブラリをインストールします。

```bash
elm package install elm-lang/mouse
elm package install elm-lang/keyboard
```

そして以下のプログラムを作成します。

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard



-- モデル


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- メッセージ


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- ビュー


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



-- サブスクリプション(購読)


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

このプログラムをElm reactorで実行すると、マウスをクリックするたびにカウンターが1ずつ増えます。キーを押すたびにカウンターが2ずつ増加します。

---

このプログラムのサブスクリプションに関連する重要な部分を見てみましょう。

### メッセージ

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

`MouseMsg`と`KeyMsg`という2つのメッセージがあります。マウスまたはキーボードが押されたときに応じてトリガされます。

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

update関数は、それぞれのメッセージに異なる反応をします。すなわち、マウスを押すと1ずつ増やし、キーを押したときには2ずつ増やします。

### サブスクリプション(購読)

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.downs KeyMsg ➋
        ]
```

ここでは、待ち受けたいことを宣言します。 `Mouse.clicks`➊と`Keyboard.downs`➋を待ち受けたいと思っています。これらの関数はどちらも引数にメッセージコンストラクタを取り、サブスクリプションを返します。

両方を待ち受けることができるように `Sub.batch`➌を使います。バッチはサブスクリプションのリストを取り、そのすべてを含む1つのサブスクリプションを返します。
