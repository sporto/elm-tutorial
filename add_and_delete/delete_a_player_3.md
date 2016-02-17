# Delete a player 3

If the user hits yes we want to send a message back to Elm to delete the player. If they hit cancel we don't send anything and nothing happens.

## Main

Add a new port to __src/Main.elm__ so we can get the inbound message:

```elm
port getDeleteConfirmation : Signal Int
```

And map this port to a signal:

```
getDeleteConfirmationSignal : Signal Actions.Action
getDeleteConfirmationSignal =
  let
    toAction id =
      id
        |> Players.Actions.DeletePlayer
        |> PlayersAction
  in
    Signal.map toAction getDeleteConfirmation
```

Here messages coming from `getDeleteConfirmation` as wrapped as with `Players.Actions.DeletePlayer` first and then `PlayersAction`. 

At the end we finish up with a signal that emits `PlayersAction (Players.Actions.DeletePlayer playerId)`.

This signal needs to be an input to `app`:

```elm
app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal, actionsMailbox.signal, getDeleteConfirmationSignal ]
    , update = update
    , view = view
    }
 ```
 
This is how __src/Main.elm__ looks at this point <https://github.com/sporto/elm-tutorial-app/blob/0610-delete-player/src/Main.elm>
 
Now we get the message back from JavaScript and we map it to the `DeletePlayer` players action.

Let's add the code in __src/Players/Update.elm__ to respond to this action, add a new branch:

```elm
    DeletePlayer playerId ->
      ( model.players, delete playerId )
```

This returns the `delete` effect we created before.