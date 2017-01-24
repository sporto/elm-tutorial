> This page covers Elm 0.18

# 메시지

필요한 메시지부터 추가해 봅시다.

__src/Players/Messages.elm__ 에 추가합니다:

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
```

- `ChangeLevel` 은 사용자가 레벨 변경을 시도할 때 생성됩니다. 두번째 인자는 레벨이 얼만큼 변경되어야 하는지를 가리키는 정수입니다. (예: -1 은 감소, 1 은 증가)
- 이후 API 에 플레이어 업데이트 요청을 보냅니다. API 에서 응답이 오면 `OnSave` 가 호출됩니다.
- `OnSave` 는 성공인 경우 업데이트된 플레이어를, 실패인 경우 Http 에러 객체를 포함합니다.
