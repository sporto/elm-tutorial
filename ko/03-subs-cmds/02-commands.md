> This page covers Elm 0.18

# 커맨드

Elm 에서 커맨드 (Cmd) 란, 외부에 사이드 이펙트를 포함하는 어떤 동작을 요청하는 것입니다. 예:

- 랜덤한 수 생성
- http 요청
- 로컬 스토리지에 무언가를 저장

`Cmd` 는 하나일 수도 있고 여럿의 묶음일 때도 있습니다. 우리는 외부에서 발생시킬 일들을 커맨드로 묶어 런타임에 전달하고 런타임은 외부에서 이를 실행하여 결과를 우리 어플리케이션에 돌려줍니다.

사실 Elm 과 같은 함수형 언어에서는 모든 결과를 리턴으로만 전달하고, 몇몇 언어에서 볼 수 있는 함수 내부에서의 사이드 이펙트의 유발은 허용하지 않으며 커맨드는 이런 동작을 처리하기 위한 것입니다. Elm 아키텍쳐에서, Html.program 은 이런 커맨드의 최종 수신자라고 볼 수 있습니다.

커맨드를 사용하는 예제 앱을 만들어 봅시다:

```elm
module Main exposing (..)

import Html exposing (Html, div, button, text, program)
import Html.Events exposing (onClick)
import Random


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )



-- MESSAGES


type Msg
    = Roll
    | OnResult Int



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Roll ] [ text "Roll" ]
        , text (toString model)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate OnResult (Random.int 1 6) )

        OnResult res ->
            ( res, Cmd.none )



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
```

실행하면 클릭할 때마다 랜덤한 수를 생성하는 버튼을 볼 수 있습니다.

---

중요한 부분을 살펴보겠습니다:


### 메시지

```elm
type Msg
    = Roll
    | OnResult Int
```

메시지는 두가지입니다. `Roll` 는 새로운 수를 요청합니다. `OnResult` 는 `Random` 라이브러리에서 생성한 수를 돌려받습니다.

### Update

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate➊ OnResult (Random.int 1 6) )

        OnResult res ->
            ( res, Cmd.none )
```

➊ `Random.generate` 는 랜덤한 수를 생성하도록 요청하는 커맨드를 만듭니다. 첫 인자는 메시지 생성자인데, 우리 어플리케이션에 돌아오도록 하기 위한 것입니다. 이 경우는 `OnResult` 입니다.

커맨드가 처리되고 나면 Elm 은 `OnResult` 에 생성된 수를 담아 메시지를 생성합니다. (예: `OnResult 2`) 이후 __Html.program__ 이 메시지를 다시 어플리케이션으로 가져옵니다.

---

많은 컴포넌트가 중첩된 거대한 어플리케이션에서는 다양한 커맨드를 한 번에 __Html.program__ 로 보낼 필요도 있습니다. 이 다이어그램을 참조하세요:

![Flow](02-commands.png)

여기서는 세 레벨에 걸쳐 커맨드를 조합하고 있습니다. 최종적으로 모든 커맨드는 __program__ 으로 전달됩니다.
