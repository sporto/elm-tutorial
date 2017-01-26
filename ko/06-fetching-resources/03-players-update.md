> This page covers Elm 0.18

# 플레이어 업데이트

플레이어 요청이 처리되면 `OnFetchAll` 메시지가 발생합니다.

__src/Players/Update.elm__ 에서 이 메시지에 대응할 겁니다. `update` 를 변경합니다:

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        OnFetchAll (Err error) ->
            ( players, Cmd.none )
```

패턴 매칭으로 상황에 따른 동작을 구분합니다.

- `Ok` 인 경우 가져온 플레이어로 리턴합니다.
- `Err` 인 경우 일단은 변경 없이 리턴합니다. (에러를 사용자에게 표현하는게 이상적이지만, 튜토리얼을 간소화 하기 위해 생략합니다)
