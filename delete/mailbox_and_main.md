# Showing a confirmation dialogue

## Mailbox

In __src/Mailbox.elm__ add a new mailbox for the confirmation request:

```elm
askDeleteConfirmationMailbox : Signal.Mailbox ( Int, String )
askDeleteConfirmationMailbox =
  Signal.mailbox ( 0, "" )
```
<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/Mailboxes.elm>

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

<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/Update.elm>

---

So far

- We have a mailbox for delete confirmation requests
- we pass its address to Players.Update
- when the user clicks the delete button we send a message to this mailbox

## Main

In Elm __ports__ are the how you communicate between JavaScript and Elm.

We want a port that sends the signal from `askDeleteConfirmationMailbox` to JavaScript. In __src/Main.elm__ add:

```elm
port askDeleteConfirmation : Signal ( Int, String )
port askDeleteConfirmation =
  askDeleteConfirmationMailbox.signal
```

<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/Main.elm>

## index.js

In __src/index.js__ we want to subscribe to this port. Add:

```elm
app.ports.askDeleteConfirmation.subscribe(function (args) {
  console.log('askDeleteConfirmation', args);
  var id = args[0];
  var message = args[1];
  var response = window.confirm(message);
})
```

<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/index.js>

---

### Try it

When you hit a player's delete button a confirmation dialogue should pop up with the player's name.


