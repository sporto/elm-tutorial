# Showing Errors 3

In the previous section we required a `showErrorAddress` in Players.Update.

We need to provide this address and do map it to the main action we want (`ShowError`).

## Auxiliary mailbox

Unfortunately StartApp doesn't give a mechanism to send messages to its address from `update`. We need to provide our own mailbox for this.

Create __src/Mailboxes.elm__:

```elm
module Mailboxes (..) where

import Actions exposing (..)

actionsMailbox : Signal.Mailbox Action
actionsMailbox =
  Signal.mailbox NoOp
```

Here we have a mailbox where we can send any root action we want to run.

## Hook the mailbox to StartApp

In __src/Main.elm__ add `actionsMailbox` as an input to StartApp:

```elm
...
import Mailboxes exposing (..)

...

app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal, actionsMailbox.signal ]
    , update = update
    , view = view
    }
```

Note the new input `actionsMailbox.signal` to StartApp. Now message going to `actionsMailbox.address` will be re-broadcasted and picked up by `app`.

## Main Update

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

---

Try it! When you refresh your browser you should see an error message in the page.

