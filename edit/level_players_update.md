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



```elm
          List.map fxForPlayer model.players
            |> Effects.batch
```