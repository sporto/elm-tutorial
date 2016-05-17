# Main Update


`Players.Udpate` expects a `showErrorAddress` so we need to pass that. Modify __src/Update.elm__ to pass that in the `PlayersAction` branch:

```elm
...
import Mailboxes exposing (..)


...
    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players
          , showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError
          }

        ( updatedPlayers, fx ) =
          Players.Update.update subAction updateModel
      in
        ( { model | players = updatedPlayers }, Effects.map PlayersAction fx )
```

We added `showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError` to `updateModel`.

We pass an address that will tag all messages with the `ShowError` action. This is what we have:

- Players.Update gets an error, sends a message to `showErrorAddress` (through an effect)
- All messages coming through `showErrorAddress` are tagged as `ShowError`
- Main Update picks up `ShowError` and modifies the main model adding the message to `errorMessage`
- The Main View shows this error message.

