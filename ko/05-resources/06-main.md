> This page covers Elm 0.18

# 메인

이제 __src/Main.elm__ 이 `initialModel` 을 호출하게 합니다:

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


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

`initialModel` 을 임포트와 `init` 에 추가했습니다.

---

어플리케이션을 실행하면 유저 하나가 포함된 리스트를 볼 수 있습니다.

![Screenshot](screenshot.png)

현재까지 진행한 코드는 <https://github.com/sporto/elm-tutorial-app/tree/018-04-resources> 와 같습니다.

