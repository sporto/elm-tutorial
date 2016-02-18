# Players Update

We created to new actions: `CreatePlayer` and `CreatePlayerDone`. We need __src/Players/Update.elm__ to account for these. 

## Respond to CreatePlayer

`CreatePlayer` will be called when the user hits the add player button. This action will trigger an effect to create the player on the API.

Add some imports:

```elm
...
import Task
import Players.Effects exposing (..)
```

Add one branch for `CreatePlayer`:

```elm
    CreatePlayer ->
      ( model.players, create new )
```

This branch returns the `create` effect from `Players.Effects` we added before. `new` creates an empty player, this comes from `Players.Models`. So we return an effect to create a new empty player.

## Respond to CreatePlayerDone

After the task to create the player is done and we have a response from the API the action `CreatePlayerDone` will be triggered.

Add another branch for `CreatePlayerDone`:

```elm
...
    CreatePlayerDone result ->
      case result of
        Ok player ->
          let
            updatedCollection =
              player :: model.players

            fx =
              Task.succeed (EditPlayer player.id)
                |> Effects.task
          in
            ( updatedCollection, fx )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.players, fx )
```

- `result` will be ` (Result Http.Error Player)` as defined in `Players.Actions`.

- If successful we get `Ok player`, in this case we add the player to the beginning of the collection with ` player :: model.players`.

- Also after we added the player we want to navigate to the edit player view. So we return an effect to do this with `Task.succeed (EditPlayer player.id) |> Effects.task`

- In case of error we get `Err error`. We then follow the pattern we had before to show errors in the main view.

