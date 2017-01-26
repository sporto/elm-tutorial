> This page covers Elm 0.18

# 계획

플레이어 레벨 변경 기능을 위한 계획은 다음과 같습니다:

![Flow](01-plan.png)

(1) 사용자가 increase 나 decrease 버튼을 누르면 `ChangeLevel` 에 `playerId` 와 `howMuch` 를 담아 호출합니다.

(2) __Html.program__ (Navigation.program 이 감싸고 있는) 은 이 메시지를 `Main.Update` 로 전달하고 메인에서는 `Players.Update` 로 전달합니다. (3)

(4) `Players.Update` 는 백엔드 저장을 위한 커맨드를 리턴하고, 이 커맨드는 __Html.program__ 으로 흘러갑니다. (5)

(6) Elm 런타임에서 커맨드를 실행 (API 호출) 하고 우리는 성공 혹은 실패라는 결과를 받습니다. 성공인 경우 `SaveSuccess` 메시지가 갱신된 플레이어와 함께 호출됩니다.

(7) `Main.Update` 는 `SaveSuccess` 메시지를 `Player.Update` 로 보냅니다.

(8) `Player.Update` 에서 `players` 모델을 업데이트해서 리턴합니다. 이는 Html.program 으로 전달됩니다. (9)

(10) Html.program 은 바뀐 모델로 뷰를 그립니다.
