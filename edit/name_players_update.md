# Players Update

Finally, __src/Players/Update.elm__ needs to account for `ChangeName` action.

Add a new branch:

```elm
    ChangeName playerId newName ->
      let
        fxForPlayer player =
          if player.id /= playerId then
            Effects.none
          else
            let
              updatedPlayer =
                { player | name = newName }
            in
              save updatedPlayer

        fx =
          List.map fxForPlayer model.players
            |> Effects.batch
      in
        ( model.players, fx )
```

Here we do the same as we did when modifying the level, we return a batch of effects to run. Most of the effects will be `Effects.none` except one for the updated player which will be `save`.

`save` is the same effect we used for changing the level because we are just updating a property of the player and hitting the same end point on the API.

When the `save` effect is done 

