> This page covers Elm 0.18

# 이동

뷰 간에 이동 가능하도록 버튼을 추가해 봅시다.

## EditPlayer 메시지

__src/Players/Messages.elm__ 에 새 메시지 둘을 추가합니다:

```elm
...

type Msg
    = OnFetchAll (Result Http.Error (List Player))
    | ShowPlayers
    | ShowPlayer PlayerId
```

`ShowPlayers` 와 `ShowPlayer` 를 추가했습니다.

## 플레이어 리스트

플레이어 리스트에는 플레이어 별로 `ShowPlayer` 메시지를 보낼 수 있는 버튼이 필요합니다.

__src/Players/List.elm__ 에서 `Html.Events` 를 임포트합니다:

```elm
import Html.Events exposing (onClick)
```

버튼을 위한 함수를 맨 아래 추가합니다:

```elm
editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

편집할 플레이어 아이디를 `ShowPlayer` 메시지에 담아 생성하고 있습니다.

`playerRow` 에 이 버튼을 추가합니다:

```elm
playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player ]
        ]
```

## 플레이어 편집

편집 화면에도 이동 버튼을 추가합시다. __/src/Players/Edit.elm__ 에서:

임포트를 추가합니다:

```elm
import Html.Events exposing (onClick)
```

리스트로 가는 버튼 함수를 마지막에 추가합니다:

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

버튼을 클릭하면 `ShowPlayers` 메시지를 보내도록 했습니다.

`nav` 함수를 변경하여 버튼을 추가합니다:

```elm
nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```

## 플레이어 업데이트

__src/Players/Update.elm__ 에서도 새 메시지에 대한 처리가 필요합니다.

```elm
import Navigation
```

case 구문에 두 분기를 추가합니다:

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        ...

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ id) )
```

`Navigation.newUrl` 은 커맨드를 리턴합니다. Elm 에서 이 커맨드를 수행하면 브라우저의 경로가 변경됩니다.

## 테스트

`http://localhost:3000/#players` 로 갑니다. Edit 버튼을 누르면 편집 뷰로 이동할 겁니다.

현재까지의 코드는 다음과 같습니다. <https://github.com/sporto/elm-tutorial-app/tree/018-07-navigation>
