> This page covers Elm 0.18

# 조합하기

Elm 아키텍쳐의 강점 중 하나는 컴포넌트를 조합하는 방식입니다. 이해를 위한 예제를 하나 만들어 봅시다:

- 부모 컴포넌트 `App` 이 있고
- 자식 컴포넌트 `Widget` 이 있다고 합시다

## 자식 컴포넌트

자식 컴포넌트부터 시작합시다. __Widget.elm__ 에 들어갈 코드입니다.

```elm
module Widget exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }



-- MESSAGES


type Msg
    = Increase



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.count) ]
        , button [ onClick Increase ] [ text "Click" ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | count = model.count + 1 }, Cmd.none )
```

서브스크립션과 메인 함수가 없다는 걸 제외하면 이전 프로그램과 거의 동일합니다. 이 컴포넌트는:

- 자체 메시지를 가지고 (Msg)
- 자체 모델을 가지고
- 자체 메시지에 대응하는 `update` 함수를 가진다. (예: `Increase`)

컴포넌트가 자체 선언한 데이터만을 다루고 있는 것을 보세요. `view` 와 `update` 에서 사용하는 `Msg` 와 `Model` 가 그렇습니다.

다음은 부모 컴포넌트를 만들어 봅시다.
