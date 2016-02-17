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

At the end we end up with a signal that emits `PlayersAction Players.Actions.DeletePlayer playerId`

