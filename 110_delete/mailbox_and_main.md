# Showing a confirmation dialogue

`Players.Update` expects a `deleteConfirmationAddress` where to send a request for confirmation. We will do this using a new Mailbox.

## Mailbox

In __src/Mailboxes.elm__ add a new mailbox for the confirmation request:

```elm
askDeleteConfirmationMailbox : Signal.Mailbox ( Int, String )
askDeleteConfirmationMailbox =
  Signal.mailbox ( 0, "" )
```
<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/Mailboxes.elm>

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
<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/Update.elm>

We don't need to add an import as we already have `import Mailboxes exposing (..)`.

---

So far

- We have a mailbox for delete confirmation requests
- We pass its address to Players.Update
- When the user clicks the delete button we send a message to this mailbox

## Main

In Elm __ports__ are the how you communicate between JavaScript and Elm.

We want a port that sends the signal from `askDeleteConfirmationMailbox` to JavaScript. In __src/Main.elm__ add:

```elm
port askDeleteConfirmation : Signal ( Int, String )
port askDeleteConfirmation =
  askDeleteConfirmationMailbox.signal
```

<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/Main.elm>

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

<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/index.js>

---

### Try it

When you hit a player's delete button a confirmation dialogue should pop up with the player's name.


