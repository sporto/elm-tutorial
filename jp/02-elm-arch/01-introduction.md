>This page covers Elm 0.18

# はじめに

Elmのフロントエンドアプリケーションを構築する際には、Elmアーキテクチャと呼ばれるパターンを使用します。このパターンは、再利用、結合、構成など多様性を持った自己完結型コンポーネントを作成する方法を提供します。

Elmはこのための `Html.program`モジュールを提供しています。これを理解するために小さなアプリを構築してみましょう。

elm-htmlをインストールする：

```elm
elm package install elm-lang/html
```

__App.elm__というファイルを作成します。

```elm
module App exposing (..)

import Html exposing (Html, div, text, program)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


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

以下のようにこのプログラムを実行することができます：

```bash
elm reactor
```

そして http://localhost:8000/App.elm を開きます。

これは "Hello"を表示するためのコードですが、非常に複雑になり得るElmアプリケーションの構造を理解するのに役立ちます。
