> This page covers Elm 0.18

## 플레이어 편집 뷰

앞에서 `ChangeLevel` 메시지를 만들었습니다. 플레이어 편집 뷰에서 이 메시지가 호출되도록 해 봅시다.

__src/Players/Edit.elm__ 에서 `btnLevelDecrease` 와 `btnLevelIncrease` 를 변경합니다:

```elm
...
btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]
```

`onClick (ChangeLevel player.id howMuch)` 를 두 버튼에 추가했습니다. `howMuch` 는 감소인 경우 `-1` 이 되고 증가인 경우 `1` 이 됩니다.
