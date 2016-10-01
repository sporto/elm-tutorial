# 訊息（Messages）

上一章節中，使用 Html.App 建立一個應用程式，只有靜態 Html。現在，使用訊息讓我們建立可以回應使用者的互動應用程式。

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.App


-- 模型


type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )



-- 訊息


type Msg
    = Expand
    | Collapse



-- 視界


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



-- 訂閱


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- 主程式


main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

這個程式與先前的十分相似，不同的是兩個新訊息：`Expand` 及 `Collapse`。你可以複製貼上程式碼到某個檔案，執行 Elm reactor 開啟這個檔案。

讓我們更靠近點看看 `view` 及 `update` 函式。

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

注意到 `onClick` 函式。因為這個視界的型別是 `Html Msg`，所以可以使用 `onClick` 來觸發該型別的訊息。Collapse 及 Expand 都是 Msg 型別。

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

`update` 用來回應訊息。根據不同的訊息，傳回要求的狀態。當訊息為 `Expand`，新的狀態將會是 `True`（表示展開）

接下來，我們將看看 __Html.App__ 如何將這些片段安排在一起。
