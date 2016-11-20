>このページでは、Elm 0.18

# ペイロードを含むメッセージ

メッセージにペイロードを含めて送ることができます：

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- モデル


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


-- メッセージ


type Msg
    = Increment Int



-- ビュー


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Increment 2) ] [ text "+" ]
        , text (toString model)
        ]


-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )



-- サブスクリプション(購読)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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

`Increment`メッセージが整数を必要とすることに注意してください：

```elm
type Msg
    = Increment Int
```

次に、`view`内でペイロードでメッセージをトリガーします。

```elm
onClick (Increment 2)
```

そして最後にupdateでは、__パターンマッチング__を使用してペイロードを抽出します。

```elm
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )
```
