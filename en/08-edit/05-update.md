# Players Update

Finally we need to account for the new messages in our `update` function. In __src/Players/Update.elm__:

Add a new import:

```elm
import Players.Commands exposing (save)
import Players.Models exposing (Player, PlayerId)
```

## Create update commands

Add a helper function for creating commands for saving a player to the API.

```
changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer
```

This function will be called when we receive the `ChangeLevel` message. This function:

- Receives the player id and the level difference to increase / decrease
- Receives a list of existing players
- Maps through each of the players on the list comparing its id with the id of the player we want to change
- If the id is the one we want then we return a command to change the level of that player
- And finally returns a list of commands to execute

## Update the players

Add another helper function for updating a player when we receive the response from the server:

```elm
updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select
```

This function will be used when we receive an updated player from the API via `SaveSuccess`. This function:

- Takes the updated player and a list of existing players
- Maps through each of the players comparing their ids with the updated player
- If the ids are the same then we return the updated player, otherwise we return the existing player

## Add branches to update

Add new branches to the `update` function:

```elm
update message players =
    case message of
        ...

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        SaveSuccess updatedPlayer ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        SaveFail error ->
            ( players, Cmd.none )
```

- In `ChangeLevel` we call the helper function `changeLevelCommands` we defined above. That function return a list of commands to run, so we then batch them into one command using `Cmd.batch`.
- In `SaveSuccess` we call the helper function `updatePlayer` which will update the relevant player from the list.

---

# Try it

This is all the setup necessary for changing a player's level. Try it, go to the edit view and click the - and + buttons. You should see the level changing and if you refresh your browser that change should be persisted on the server.
