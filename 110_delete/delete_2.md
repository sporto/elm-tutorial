# Responding to DeletePlayerIntent

We added a new button to Players.List that will trigger the `DeletePlayerIntent` action.

__src/Players/Update__ needs to account for this action. Change the `UpdateModel` model:

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
    
    DeletePlayer playerId ->
      (model.players, Effects.none)
```

<https://github.com/sporto/elm-tutorial-app/blob/110-delete-player/src/Players/Update.elm>

When `DeletePlayerIntent` is triggered we respond with an effect to send a message to `deleteConfirmationAddress`. The message will be tuple with `(playerId, "Are you sure you want to delete name?")`.

We need to provide this `deleteConfirmationAddress` to this `update` function.

In order to compile the code we also need to account for `DeletePlayer` and `DeletePlayerDone`, so for now we just add two branches that return the model and Effects.none.
















