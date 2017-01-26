> This page covers Elm 0.18

# 메인

## 메인 모델

__src/Models.elm__ 의 하드코드된 플레이어 목록을 지웁니다

```elm
initialModel : Model
initialModel =
    { players = []
    }
```

## 메인

이제 어플리케이션 시작과 동시에 `fetchAll` 이 실행되도록 합니다.

__src/Main.elm__ 을 수정합니다:

```elm
...
import Messages exposing (Msg(..))
...
import Players.Commands exposing (fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map PlayersMsg fetchAll )
```

이제 어플리케이션 시작 시 `init` 에서 커맨드가 전달됩니다.
