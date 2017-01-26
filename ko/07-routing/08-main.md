> This page covers Elm 0.18

# 메인

이제 메인 모듈에서 전부 엮어 봅시다.

__src/Main.elm__ 를 변경합니다:

```elm
module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

---

### 새로운 임포트

`Navigation` 과 `Routing` 을 추가했습니다.

### 초기화

```elm
init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

이제 init 함수는 `Navigation` 으로부터 전달된 `Location` 을 받습니다. 이 `Location` 을 파싱하기 위해 이전에 만든 `parseLocation` 함수를 사용했고, 리턴된 __route__ 는 모델에 저장합니다.

### main

`main` 은 이제 `Html.program` 이 아닌 `Navigation.program` 을 사용합니다. `Navigation.program` 은 `Html.program` 을 감싸고 브라우저 경로 변경 시 메시지를 발생시킵니다. 이 앱에서는 `OnLocationChange` 가 그 메시지입니다.
