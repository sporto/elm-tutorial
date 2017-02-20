> This page covers Tutorial v2. Elm 0.18.

# Update

Finally we need to account for the new messages in our `update` function. In __src/Update.elm__:

Add a new imports:

```elm
import Commands exposing (savePlayerCmd)
import Models exposing (Model, Player)
import RemoteData
```

## New messages

Update branches to update to handle the newly created messages:

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ...

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )
```

### ChangeLevel

In `ChangeLevel` we first update the `level` attribute for the given player and then return a command `savePlayerCmd` to save it.

### OnPlayerSave

When we get `OnPlayerSave` back we pattern match so we handle the success and failure case differently. On the failure case we are just discarding the error and leaving the model as it was. This is not great but for simplicity we will do it like this.

In the success case we are calling a helper function `updatePlayer` to update the changed player, we will write this function next.

## Update the player

Add a helper function to update the player:

```elm
updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
```

This function is called after we get an updated player from the API. This function needs to swap an existing player in our model for the updated player coming from the API.

We don't know what is in `model.players`, it could be `RemoteData.Loading` or `RemoteData.Success players` or some other case. So first we need to account for this. `RemoteData` provides a `map` function that only applies when we have `RemoteData.Success`. We use this in `updatedPlayers`.

`updatePlayerList` will only be called if `model.players` is `RemoteData.Success players`. `updatePlayerList` is a function that maps over a list of players and swaps the updated player.

---

# Try it

This is all the setup necessary for changing a player's level. Try it, go to the edit view and click the - and + buttons. You should see the level changing and if you refresh your browser that change should be persisted on the server.

Up to this point your application code should look <https://github.com/sporto/elm-tutorial-app/tree/018-v02-08-edit>.
