# 裝載訊息（Messages with payload）

你可以在訊息上額外裝載資料：

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.App


-- 模型


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- 訊息


type Msg
    = Increment Int



-- 視界


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



-- 訂閱


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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

注意到以下 `Increment` 訊息要求額外的整數：

```elm
type Msg
    = Increment Int
```

接著，在視界函式裡面，觸發該訊息並裝載額外資料：

```elm
onClick (Increment 2)
```

最後在更新函式中，使用__樣式對應__取出裝載資料： 

```elm
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )
```
