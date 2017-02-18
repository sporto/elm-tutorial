> This page covers Tutorial v2. Elm 0.18.

# Players Update

When the request for players is done, we trigger the `OnFetchAll` message.

__src/Players/Update.elm__ should account for this new message. Change `update` to:

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        OnFetchAll (Err error) ->
            ( players, Cmd.none )
```

When we get `OnFetchAll` we can use pattern matching to decide what to do. 

- In the `Ok` case we return the fetched players in order to update the players collection.
- In the `Err` case we just return what we had before for now (A better approach would be to show an error to the user, but for simplicity of the tutorial we won't be doing this now).
