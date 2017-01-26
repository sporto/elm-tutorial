# 리소스: 플레이어

앱에서 사용될 리소스 기준으로 앱 구조를 정리해 볼 겁니다. 지금은 리소스가 하나 밖에 (`Players`) 없으므로 `Players` 디렉토리 하나만 만들면 됩니다.

`Players` 디렉토리 내부도 부모처럼 Elm 아키텍쳐의 각 컴포넌트를 모듈로 가집니다:

- Players/Messages.elm
- Players/Models.elm
- Players/Update.elm

하지만 플레이어를 위한 다른 뷰도 있어요: 리스트와 에딧 뷰입니다. 이 뷰들도 각자의 Elm 모듈을 가집니다:

- Players/List.elm
- Players/Edit.elm

