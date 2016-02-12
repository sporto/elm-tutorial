# Navigation from List to Edit

Next let add an "Edit" button to the players' list.

## EditPlayer action

Add a new action `EditPlayer` in __src/Players/Actions.elm__

```elm
...

type Action
  = NoOp
  | HopAction Hop.Action
  | EditPlayer PlayerId
```

We will trigger this action when we intent to edit a player.


## Players List

The players' list needs to show a button for each player that triggger this action. 

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

Here we trigger `EditPlayer` with the id of the player that we want to edit. To do this we send the `EditPlayer` with the use id to the address.

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

## Players Update

Finally __src/Players/Update.elm__ needs to respond to this action. Add a new branch to the case expression:

```elm
    ...

    EditPlayer id ->
      let
        path =
          "/players/" ++ (toString id) ++ "/edit"
      in
        ( model.players, Effects.map HopAction (Hop.navigateTo path) )

    NoOp ->
      ...
```

`Hop.navigateTo path` returns an effect. When this effect is run by Elm the location of the browser will change. You can read more about how this works [here](https://github.com/sporto/hop).

## Test it

Go to the list `http://localhost:3000/#/players`. You should now see an Edit button, upon clicking it the location should change to the edit view.