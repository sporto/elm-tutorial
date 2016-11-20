## プレイヤー編集ビュー

私たちは `ChangeLevel`メッセージを作成しました。 このメッセージをプレイヤーの編集ビューからトリガーしましょう。

__src/Players/Edit.elm__で `btnLevelDecrease`と`btnLevelIncrease`を変更してください：

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

これらの2つのボタンに`onClick(ChangeLevel player.id howMuch)`を追加しました。ここで`howMuch`はレベルを下げる場合は`-1`、レベルを下げ場合には`1`になります。
