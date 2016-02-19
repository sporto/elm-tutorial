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

