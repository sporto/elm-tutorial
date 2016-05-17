# Getting confirmation

We create a `askDeleteConfirmationMailbox` where to send request for confirmation to delete a player. This mailbox is connected to a port that sends the message to JavaScript. 

When the JavaScript side receives a message (via this port) it opens a confirmation dialogue. If the user hits yes we want to send a message back to Elm to delete the player. If they hit cancel we don't send anything and nothing happens.

## getDeleteConfirmation port

Add a new port to __src/Main.elm__ so we can get the inbound message from JavaScript:

```elm
port getDeleteConfirmation : Signal Int
```

## Index.js

In the JavaScript side we need to send a message upon confirmation to the `getDeleteConfirmation` port:

```elm
var app = Elm.embed(Elm.Main, mountNode, {getDeleteConfirmation: 0});

app.ports.askDeleteConfirmation.subscribe(function (args) {
  console.log('askDeleteConfirmation', args);
  var id = args[0];
  var message = args[1];
  var response = window.confirm(message);
  if (response) {
    app.ports.getDeleteConfirmation.send(id);
  }
})
```

As this is an inbound port we need to provide an initial value:

```js
var app = Elm.embed(Elm.Main, mountNode, {getDeleteConfirmation: 0});
```

Then if the user clicks yes we send a message to the port:
```js
  if (response) {
    app.ports.getDeleteConfirmation.send(id);
  }
```

<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/index.js>

## getDeleteConfirmationSignal

Back in __src/Main.elm__ map the `getDeleteConfirmation` port to a signal:

```elm
import Players.Actions
```

```elm
getDeleteConfirmationSignal : Signal Actions.Action
getDeleteConfirmationSignal =
  let
    toAction id =
      id
        |> Players.Actions.DeletePlayer
        |> PlayersAction
  in
    Signal.map toAction getDeleteConfirmation
```

Here messages coming from `getDeleteConfirmation` as wrapped as with `Players.Actions.DeletePlayer` first and then `PlayersAction`. 

At the end we finish up with a signal that emits `PlayersAction (Players.Actions.DeletePlayer playerId)`.

This signal needs to be an input to `app`:

```elm
app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal, actionsMailbox.signal, getDeleteConfirmationSignal ]
    , update = update
    , view = view
    }
 ```
 
Now we get the message back from JavaScript and we map it to the `DeletePlayer` players action.

This is how __src/Main.elm__ looks at this point <https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/Main.elm>

