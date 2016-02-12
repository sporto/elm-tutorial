# Navigation from List to Edit

## EditPlayer action



## Players List

The players' list needs to show a button for each player in order to go to that player's edit view. 

In __src/Players/List.elm__. Add a new function for this button at the end:

```elm
editBtn : Signal.Address Action -> Player -> Html.Html
editBtn address player =
  button
    [ class "btn regular"
    , onClick address (EditPlayer player.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

Here we trigger `EditPlayer` with the id of the player that we want to edit.

And change `playersRow` to include this button:

```elm
playerRow : Signal.Address Action -> ViewModel -> Player -> Html.Html
playerRow address model player =
  let
    bonuses =
      999

    strength =
      bonuses + player.level
  in
    tr
      []
      [ td [] [ text (toString player.id) ]
      , td [] [ text player.name ]
      , td [] [ text (toString player.level) ]
      , td [] [ text (toString bonuses) ]
      , td [] [ text (toString strength) ]
      , td
          []
          [ editBtn address player ]
      ]
```