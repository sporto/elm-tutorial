# 簡介

當使用 Elm 建構前端應用程式時，我們使用常見的樣式：Elm 架構（The Elm Architecture）。這個樣式提供了一種建立自我包含的元件（self contained components）的方式，能夠再利用（reused）、合併（combined）、組成（composed）達到無止境的變化。

Elm 提供了 `Html.App` 模組。透過建置一個小的應用程式比較容易理解。

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

執行下列命令來啟動程式：

```bash
elm reactor
```

接著使用瀏覽器開啟網址 http://localhost:8000/App.elm

上述程式碼很多，只顯示了 "Hello"，但幫助我們了解整體架構，甚至是非常複雜的 Elm 應用程式也一樣。
