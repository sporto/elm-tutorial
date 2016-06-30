# Players Update

When the request for players is done, we trigger the `FetchAllDone` message.

__src/Players/Update.elm__ should account for this new message. Change `update` to:

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )
```

The message `FetchAllDone` has the fetched players, so we return that payload to update the players collection.

`FetchAllFail` matches in the case of an error. For now we will just return what we had before.
