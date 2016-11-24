>This page covers Elm 0.18

# メッセージ

先のセクションでは、Html.programを使って静的なHtmlを使用するアプリケーションを作成しました。次に、メッセージを使ってユーザーとやりとりをするアプリケーションを作成しましょう。

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- モデル


type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )



-- メッセージ


type Msg
    = Expand
    | Collapse



-- VIEW


view : Model -> Html Msg
view model =
    if model then
        div []
            [ button [ onClick Collapse ] [ text "Collapse" ]
            , text "Widget"
            ]
    else
        div []
            [ button [ onClick Expand ] [ text "Expand" ] ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )



-- サブスクリプション(購読)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

このプログラムは以前のプログラムと非常によく似ていますが、今は`Expand`と`Collapse`という2つのメッセージがあります。このプログラムをファイルにコピーし、Elm reactorを使用して開くことができます。

`view`と`update`関数をもっと詳しく見てみましょう。

### 表示

```elm
view : Model -> Html Msg
view model =
    if model then
        div []
            [ button [ onClick Collapse ] [ text "Collapse" ]
            , text "Widget"
            ]
    else
        div []
            [ button [ onClick Expand ] [ text "Expand" ] ]
```

モデルの状態に応じて、折りたたまれたビューまたは拡大されたビューのいずれかが表示されます。

`onClick`関数に注意してください。このビューは `Html Msg`型であるため、`onClick`を使ってそのタイプのメッセージをトリガーすることができます。折りたたみと展開の両方がメッセージタイプです。

### 更新

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )
```

`update`は可能なメッセージに応答します。メッセージに応じて、目的の状態を返します。メッセージが `Expand`のとき、新しい状態は`True`(拡張)になります。

次に、__Html.program__がこれらの部分を一緒にオーケストレーションする方法を見てみましょう。
