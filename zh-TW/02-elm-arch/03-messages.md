> 本頁包含 Elm 0.18

# 訊息（Messages）

上一章節中，使用 Html.App 建立一個應用程式，這只有靜態 Html。現在，使用訊息來建構能夠回應使用者的互動程式。

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )



-- MESSAGES


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



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )



-- SUBSCRIPTIONS


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

這個程式與先前的十分相似，但不同的是，兩個新訊息：`Expand` 及 `Collapse`。你可以複製貼上程式碼到某個檔案，執行 Elm reactor 開啟這個檔案。

更靠近點看 `視界` 及 `更新` 函式。

### 視界

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

根據模型當下的狀態來決定展開或收縮視界。

注意到 `onClick` 函式。這個視界的型別是 `Html Msg`，可以使用 `onClick` 來觸發該型別的訊息。Collapse 及 Expand 都是 Msg 型別。

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

`更新` 負責回應訊息。根據不同的訊息，傳回想要的狀態。當訊息為 `Expand`，新的狀態為 `True`（表示展開）

接下來，看看 __Html.App__ 是如何將這些片段安排在一起。
