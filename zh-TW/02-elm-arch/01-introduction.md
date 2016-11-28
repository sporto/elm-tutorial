# 簡介

當在 Elm 建構前端應用程式時，使用了一種樣式，稱之為 Elm 架構（The Elm Architecture）。此樣式提供了一種能夠建立自我包含的元件（self contained components）的方式，讓再利用（reused）、合併（combined）、組成（composed）達到無止境的變化。

Elm 為此提供了 `Html.App` 模組。為了容易理解，讓我們來建置一個小型應用程式。

安裝 elm-html：

```elm
elm package install elm-lang/html
```

新增 __App.elm__ 檔案：

```elm
module App exposing (..)

import Html exposing (Html, div, text)
import Html.App


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


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

執行下列命令啟動程式：

```bash
elm reactor
```

瀏覽器開啟網址 http://localhost:8000/App.elm

上述有許多程式碼但只顯示了 "Hello"，不過幫助我們了解整體架構，甚至是複雜的 Elm 應用程式也一樣。
