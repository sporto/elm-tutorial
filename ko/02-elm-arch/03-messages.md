> This page covers Elm 0.18

# 메시지

이전 장에서는 단순히 정적 Html 엘리먼트인 앱을 만들었었죠. 이제 메시지를 가지고 상호작용이 가능한 앱을 만들어 봅시다.

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

이전 프로그램과 매우 비슷하지만, 이제 두 메시지를 가지고 있습니다: `Expand` 와 `Collapse` 입니다. 파일로 저장하고 Elm reactor 로 실행해 볼 수 있습니다.

`view` 와 `update` 함수를 좀 더 살펴봅시다.

### 뷰

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

모델의 상태에 따라 감춰진 (collapsed) 상태나 펼쳐진 (expanded) 상태로 그립니다.

`onClick` 함수를 보세요. 뷰의 타입 `Html Msg` 에 쓰인 것 처럼 `onClick` 은 해당 타입에 맞춘 메시지를 보냅니다. Collapse 와 Expand 는 Msg 타입입니다.

### 업데이트

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )
```

`update` 는 각 메시지에 대응하여 갱신된 상태를 리턴합니다. 메시지가 `Expand` 라면, 새로운 상태는 `True` 가 됩니다 (펼쳐진 상태).

이후 __Html.program__ 이 이것들을 어떻게 처리하는지 보겠습니다.
