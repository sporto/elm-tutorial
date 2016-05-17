# Application flow

The following diagram illustrates how the pieces of our application interact with Html.App.

![Flow](040-flow.png)

1. Html.App calls our view function with the initial model and renders that.
1. When the user click on the Expand button, the view triggers the `Expand` message.
1. Html.App receives this messages and calls our `update` function with it and the current application state.
1. The update function reponds to the message by returning an update state and optionally a command to run. 
1. Html.App receives the updated state, stores it and calls the view with the updated state.

Usually Html.App is the only place where an Elm application holds state, it is centralised in one big state tree.
