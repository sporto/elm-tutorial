# Delete a player 2

## Players Update

__src/Players/Update__ needs to account for the actions we added. For now let's just add `DeletePlayerIntent` so we follow the application flow. 

Change the `UpdateModel` model:

```elm
type alias UpdateModel =
  { players : List Player
  , showErrorAddress : Signal.Address String
  , deleteConfirmationAddress : Signal.Address ( PlayerId, String )
  }
```

We now require a `deleteConfirmationAddress` where to send the confirmation request.

And add a new branch to `update`:

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

When `DeletePlayerIntent` is triggered we respond with an effect to send a message to `deleteConfirmationAddress`. The message will be tuple with `(playerId, "Are you sure you want to delete name?")`.

We need to provide this `deleteConfirmationAddress` to update.

## Mailbox

In __src/Mailbox.elm__ add a new mailbox for the confirmation request:

```elm
askDeleteConfirmationMailbox : Signal.Mailbox ( Int, String )
askDeleteConfirmationMailbox =
  Signal.mailbox ( 0, "" )
```

## Update

In __src/Update__ import this mailbox and pass it to `Players.Update`:

```elm
    ...
    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players
          , showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError
          , deleteConfirmationAddress = askDeleteConfirmationMailbox.address
          }
```

We don't need to add an import as we already have `import Mailboxes exposing (..)`.

## Main





## index.js

