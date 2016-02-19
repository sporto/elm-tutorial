# Players View

We created a `ChangeLevel` action. Let's trigger this action from the player's edit view.

In __src/Players/Edit.elm__ change:

```elm
btnLevelDecrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelDecrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-minus-circle"
        , onClick address (ChangeLevel model.player.id -1)
        ]
        []
    ]


btnLevelIncrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelIncrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-plus-circle"
        , onClick address (ChangeLevel model.player.id 1)
        ]
        []
    ]
```


