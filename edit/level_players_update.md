# Players Update

We have an `ChangeLevel` that triggers when the user hits both the decrease or increase level buttons. We need to account for this action in `Players.Update`.

In __src/Players/Update.elm__ add one branch for this:

```elm
    ...
    ChangeLevel playerId howMuch ->
      let
        fxForPlayer player =
          if player.id /= playerId then
            Effects.none
          else
            let
              updatedPlayer =
                { player | level = player.level + howMuch }
            in
              if updatedPlayer.level > 0 then
                save updatedPlayer
              else
                Effects.none

        fx =
          List.map fxForPlayer model.players
            |> Effects.batch
      in
        ( model.players, fx )
```

When we get `ChangeLevel` we want to create an effect to save one player on the API. `ChangeLevel` gives us the player id that we need to update.

We could try to find this player in `model.players` using `List.filter` so we can build the effects to return. But using `List.filter` would involve adding conditional logic to deal with the potential case of not finding the player we want in the list.

Rather than doing that it is much easier to just map over all the players and return a list of effects:

```elm
  List.map fxForPlayer model.players
    |> Effects.batch
```