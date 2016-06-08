## Player edit view

We created a `ChangeLevel` message. Let's trigger this message from the player's edit view.

In __src/Players/Edit.elm__ change `btnLevelDecrease` and `btnLevelIncrease`:

```elm
...
btnLevelDecrease : Player -> Html.Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html.Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]
```

In these two buttons we added `onClick (ChangeLevel player.id howMuch)`. Where `howMuch` is `-1` to decrease level and `1` to increase it.
