> This page covers Elm 0.18

# 메인 업데이트

메인 `update` 함수에도 새 `OnLocationChange` 메시지를 위한 로직이 필요합니다.

__src/Update.elm__ 에 아래 분기를 추가합니다:

```elm
...
import Routing exposing (parseLocation)

...

update msg model =
    case msg of
        ...
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
```

`OnLocationChange` 메시지를 받아 경로를 파싱하여 루트를 구하고 모델을 변경하고 있습니다.
