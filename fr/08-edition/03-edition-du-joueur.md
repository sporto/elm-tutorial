> Cette page couvre Elm 0.18

## Vue d'édition du joueur

Maintenant que nous avons créé un message `ChangeLevel`, déclenchons le à partir de la vue d'édition du joueur.

Dans __src/Players/Edit.elm__ changez `btnLevelDecrease` en `btnLevelIncrease`:

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

Pour ces deux boutons nous avons ajouté `onClick (ChangeLevel player.id howMuch)`, où `howMuch` vaut `-1` pour diminuer de niveau et `1` pour augmenter.
