# Delete a player

Deleting a player will follow the same pattern than adding a player but with one complication: we want to show a conformation dialogue before removing the player.

The steps for this will be:

- When the user clicks the delete button trigger an action (`DeletePlayerIntent`) with the intention of delete the player
- This action will trigger a call to a port that sends a message to JavaScript
- JavaScript listens to this port and shows a window confirmation dialogue
- If the user clicks yes we send a message to Elm via another port
- This inbound port triggers an action `DeletePlayer`
- This action triggers the actual deletion

## Players Actions

Add the following actions to __src/Players/Actions.elm:

<https://github.com/sporto/elm-tutorial-app/blob/0610-delete-player/src/Players/Actions.elm>

```elm
...
  | DeletePlayerIntent Player
  | DeletePlayer PlayerId
  | DeletePlayerDone PlayerId (Result Http.Error ())
```

- `DeletePlayerIntent` will trigger when hitting the Delete button, we pass the whole player record so we can grab the `id` and the `name` later

- `DeletePlayer` will trigger after the user confirms their intention to delete the player, we just need the player id

- `DeletePlayerDone` will trigger after the delete request to the server. This action has to arguments the playerId and the result from the server. We don't need the actual body from the response so we use `()`. As long as the result is `Ok` we will know that the deletion was successful.

## Players List

In __src/Players/List.elm__ we want to have a button that triggers `DeletePlayerIntent`.

<https://github.com/sporto/elm-tutorial-app/blob/0610-delete-player/src/Players/List.elm>

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
    ...
  in
      ...
      , td
          []
          [ editBtn address player
          , deleteBtn address player
          ]
      ]
```
---

We have new actions and a delete button. In the next section we will add the code for responding to the actions.