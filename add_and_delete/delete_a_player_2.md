# Delete a player 2

## Players Update

__src/Players/Update__ needs to account for the actions we added. For now let's just add `DeletePlayerIntent` so we follow the application flow. Add a new branch to `update`:

```elm
    DeletePlayerIntent player ->
      let
        msg =
          "Are you sure you want to delete " ++ player.name ++ "?"

        fx =
          Signal.send model.deleteConfirmationAddress ( player.id, msg )
            |> Effects.task
            |> Effects.map TaskDone
      in
        ( model.players, fx )
```

## Main

## Mailbox

## Update

## index.js

