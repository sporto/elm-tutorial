> This page covers Elm 0.18

# 계획

다음 단계는 앞에서 만든 API 로부터 플레이어 목록을 받아오는 겁니다.

계획은 이러합니다:

![Plan](01-plan.png)

(1-2) 어플리케이션이 준비되는 동시에 플레이어들을 가져오는 Http 요청을 커맨드로 보냅니다. 이는 Html.program 의 `init` 에서 수행합니다.

(3-6) 요청이 해결되면 `FetchAllDone` 메시지가 데이터와 함께 호출되고, 이는 `Players.Update` 로 전달되어 플레이어 목록을 갱신하게 됩니다.

(7-10) 어플리케이션은 갱신된 플레이어 목록을 그립니다.

## 의존성

`http` 모듈이 필요하므로, 아래 명령으로 설치합니다:

```bash
elm package install elm-lang/http
```
