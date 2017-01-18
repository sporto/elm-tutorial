> This page covers Elm 0.18

# 어플리케이션 흐름

아래 다이어그램은 앱의 각 부분들이 Html.program 과 어떻게 작용하는지 보여줍니다.

![Flow](04-flow.png)

1. `Html.program` 은 뷰 함수를 초기 상태로 호출하여 처음 화면을 그린다.
1. 사용자가 Expand 버튼을 누르면, 뷰는 `Expand` 메시지를 보낸다.
1. `Html.program` 은 `Expand` 메시지를 받고 `update` 함수에 `Expand` 메시지와 현재 상태를 전달하여 호출한다.
1. update 함수는 메시지를 처리해 갱신된 상태와 실행할 커맨드를 리턴한다. (혹은 `Cmd.none`)
1. `Html.program` 는 갱신된 상태 (state) 를 받아 저장하고, view 에 전달하여 호출한다.

일반적으로는 `Html.program` 이 Elm 어플리케이션의 단일화된 트리 구조의 상태를 관리하는 유일한 곳이라고 할 수 있습니다.
