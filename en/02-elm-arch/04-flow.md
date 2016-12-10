> This page covers Elm 0.18

# Application flow

The following diagram illustrates how the pieces of our application interact with Html.program.

![Flow](04-flow.png)

1. `Html.program` calls our view function with the initial model and renders it.
1. When the user clicks on the Expand button, the view triggers the `Expand` message.
1. `Html.program` receives the `Expand` message which calls our `update` function with `Expand` and the current application state.
1. The update function responds to the message by returning the updated state and a command to run (or `Cmd.none`). 
1. `Html.program` receives the updated state, stores it, and calls the view with the updated state.

Usually `Html.program` is the only place where an Elm application holds state, it is centralised in one big state tree.
