> This page covers Elm 0.18

# 모듈 나누기

우리 앱은 곧 커질 것이고, 파일 하나에 전부를 담는 건 관리에 문제가 될 겁니다.

### 순환 의존 문제

일어날 수 있는 또 한가지 문제는 순환 의존성입니다. 예를 들면:

- `Main` 모듈은 `Player` 타입을 가지고 있다.
- `View` 모듈이 `Main` 에서 `Player` 타입을 임포트한다.
- `Main` 은 뷰를 그리기 위해 `View` 를 임포트한다.

이것이 순환 의존성입니다:

```elm
Main --> View
View --> Main
```

#### 어떻게 해결하나?

이 경우에는 `Player` 모듈을 `Main` 과 `View` 양쪽에서 임포트 가능하도록 `Main` 에서 분리해야 합니다.

Elm 에서 순환 의존을 피하는 가장 쉬운 방법은 어플리케이션을 작은 모듈로 쪼개는 겁니다. 여기서는 `Main` 과 `View` 양쪽에 임포트 될 수 있는 새로운 모듈을 만들면 됩니다. 모듈을 이렇게 세 가지로 나누면:

- Main
- View
- Models (Player 타입을 가짐)

의존성은 이렇게 됩니다:

```elm
Main --> Models
View --> Models
```

이제 순환 의존 문제가 없습니다.

__messages__, __models__, __commands__, __utilities__ 와 같이 다양한 컴포넌트에 걸쳐 사용되는 것들도 별도의 모듈로 분리할 수 있습니다.

---

어플리케이션을 더 작은 모듈로 나눠봅시다:

__src/Messages.elm__

```elm
module Messages exposing (..)


type Msg
    = NoOp
```

__src/Models.elm__

```elm
module Models exposing (..)


type alias Model =
    String
```

__src/Update.elm__

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

__src/View.elm__

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src/Main.elm__

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


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

코드는 여기서 볼 수도 있습니다. <https://github.com/sporto/elm-tutorial-app/tree/018-03-multiple-modules>

---

이렇게 많은 모듈은, 조그만 어플리케이션에는 과하다고 볼 수도 있습니다. 하지만 어플리케이션이 커질수록 분리된 구조는 작업에 도움이 됩니다.


