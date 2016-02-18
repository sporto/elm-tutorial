# Players List

In __src/Players/List.elm__ we want to have a button that triggers `DeletePlayerIntent`.

<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/Players/List.elm>

Add a new function:

```elm
deleteBtn : Signal.Address Action -> Player -> Html.Html
deleteBtn address player =
  button
    [ class "btn regular mr1"
    , onClick address (DeletePlayerIntent player)
    ]
    [ i [ class "fa fa-trash mr1" ] [], text "Delete" ]
```

This renders a button that when clicked sends the `DeletePlayerIntent` action with the player as payload to the StartApp address.

Add the button to the list in `playerRow` next to the editBtn:

```elm
...
playerRow address model player =
  tr
    []
    [ td [] [ text (toString player.id) ]
    , td [] [ text player.name ]
    , td [] [ text (toString player.level) ]
    , td
        []
        [ editBtn address player
        , deleteBtn address player
        ]
    ]
```
---

We have new actions and a delete button. In the next section we will add the code for responding to the actions.
