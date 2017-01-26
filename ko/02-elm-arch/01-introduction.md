> This page covers Elm 0.18

# 들어가며

Elm 으로 프론트엔드 어플리케이션을 개발할 때 사용하는 패턴을 Elm 아키텍쳐라 부릅니다. 이는 다양한 상황에서 재사용과 조합이 가능한 독립적인 컴포넌트를 만드는 데 적합한 패턴입니다.

Elm 은 이를 위해 `Html` 모듈을 제공합니다. 조그만 어플리케이션 하나를 만들며 알아보도록 하겠습니다.

elm-html 을 설치합니다:

```elm
elm package install elm-lang/html
```

__App.elm__ 파일을 만듭니다:

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

아래 명령으로 프로그램을 구동합니다:

```bash
elm reactor
```

http://localhost:8000/App.elm 을 열어봅니다.

단순히 "Hello" 를 보여주는 것 치고는 꽤 많은 코드지만, 아주 복잡한 Elm 앱이라도 기본 구조는 이와 비슷합니다.
