> This page covers Elm 0.18

# 플레이어 업데이트

이제 `update` 함수만 남았습니다. __src/Players/Update.elm__ 에서:

임포트를 추가합니다:

```elm
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)
```

## 커맨드 작성

플레이어를 API 를 통해 저장하는 커맨드를 생성하기 위한 함수를 만듭니다.

```elm
changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players
```

`ChangeLevel` 메시지가 오면 이 함수가 호출되게 할 겁니다. 이 함수는:

- 플레이어 아이디와 레벨 증가 / 감소 데이터를 받습니다.
- 플레이어 리스트를 받습니다.
- 플레이어 목록에 함수를 매핑하여 각 플레이어의 아이디를 검사해 우리가 변경하고자 하는 플레이어인지 결정합니다.
- 아이디가 같다면 해당 플레이어의 레벨을 변경하는 커맨드를 리턴합니다.
- 결과적으로 실행할 커맨드의 리스트가 리턴됩니다.

## 플레이어 업데이트

서버로부터 받은 응답으로 플레이어를 업데이트하는 함수를 추가합니다:

```elm
updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
```

API 호출이 성공적으로 처리되어 `SaveSuccess` 로 업데이트된 플레이어를 전달받는 경우 이 함수가 사용됩니다. 이 함수는:

- 업데이트된 플레이어와 기존 플레이어 리스트를 인자로 받습니다.
- 플레이어 목록에 함수를 매핑하여 업데이트된 플레이어와 아이디를 비교합니다.
- 아이디가 같으면 업데이트된 플레이어를, 아닌 경우 기존 플레이어를 최종 리스트에 포함시킵니다.

## 업데이트에 분기 추가

`update` 함수에 새 분기들을 추가합니다:

```elm
update message players =
    case message of
        ...

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        OnSave (Ok updatedPlayer) ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        OnSave (Err error) ->
            ( players, Cmd.none )
```

- `ChangeLevel` 의 경우 위에서 만든 `changeLevelCommands` 을 호출합니다. 커맨드 리스트가 리턴되므로, `Cmd.batch` 를 써서 커맨드 하나로 묶어 줘야 합니다.
- `OnSave (Ok updatedPlayer)` 에서는 플레이어 리스트 내 관련 플레이어들의 업데이트를 위해 `updatePlayer` 를 호출합니다.

---

# 실행해 보기

여기까지 플레이어 레벨 수정을 위한 작업이 끝났습니다. 플레이어 편집 뷰로 가서 -, + 버튼을 눌러보세요. 레벨이 바뀌고, 브라우저를 새로고침해도 값이 유지되는 것을 볼 수 있습니다.

지금까지 진행한 코드는 여기서도 볼 수 있습니다. <https://github.com/sporto/elm-tutorial-app/tree/018-08-edit>
