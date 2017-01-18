> This page covers Elm 0.18

# 서브스크립션

Elm 에서는 __subscriptions__ 을 사용하여 외부 입력에 대응합니다. 예:

- [키보드 이벤트](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- [마우스 동작](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- 브라우저 주소 변경
- [웹소켓 이벤트](http://package.elm-lang.org/packages/elm-lang/websocket/latest/WebSocket)

이해를 위해 키보드와 마우스 이벤트에 반응하는 어플리케이션을 만들어 봅시다.

우선 이 라이브러리들을 설치해야 합니다:

```bash
elm package install elm-lang/mouse
elm package install elm-lang/keyboard
```

다음, 프로그램을 작성합니다:

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]



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

Elm reactor 로 프로그램을 돌려봅니다. 마우스를 클릭할 때마다 1 씩, 키보드를 누를 때마다 2 씩 증가하는 카운터를 보실 수 있습니다.

---

서브스크립션과 관련된 부분을 다시 살펴 봅시다.

### 메시지

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

메시지는 두 가지입니다: `MouseMsg` 와 `KeyMsg`. 각각 마우스와 키보드가 눌려졌을 때 발생합니다.

### 업데이트

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )
```

update 함수에서는 메시지별로 각각 처리를 합니다. 마우스를 누를 때는 1 씩, 키보드를 누를 때는 2 씩 증가하도록 쓰여진 것을 볼 수 있습니다.

### 서브스크립션

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.downs KeyMsg ➋
        ]
```

여기서는 참조하고 싶은 것들을 명시합니다. 우리가 필요한 건 `Mouse.clicks` ➊ 과 `Keyboard.downs` ➋ 입니다. 이 함수들은 메시지 생성자를 인자로 받고, 서브스크립션 타입을 돌려줍니다.

두 이벤트를 참조해야 하므로 `Sub.batch` ➌ 를 사용합니다. `batch` 는 서브스크립션의 리스트를 받아 모두를 포함하는 하나의 서브스크립션을 리턴합니다.
