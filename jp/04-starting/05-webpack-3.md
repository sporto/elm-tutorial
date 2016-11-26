> This page covers Elm 0.18

# Webpackその3

## 最初のElmアプリケーション

基本的なElmアプリケーションを作成します。 __src/Main.elm__では：

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)

-- モデル


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- メッセージ


type Msg
    = NoOp



-- ビュー


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



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
