# Add player part 2

## Players Update

We need __src/Players/Update.elm__ to account for the new actions created. Add some imports:

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

## Players List

Finally, let's add the add player button to the players' list.

In __src/Players/List.elm__ add:

```elm
...

addBtn : Signal.Address Action -> ViewModel -> Html.Html
addBtn address model =
  button
    [ class "btn", onClick address CreatePlayer ]
    [ i [ class "fa fa-user-plus mr1" ] []
    , text "Add player"
    ]
 ```

This renders a button that when clicked send the `CreatePlayer` action. Which trigger the effect to create the player in `Players.Update`.

And add the button to the navigation in this module:

```elm
...
nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Players" ]
    , div [ class "right p1" ] [ addBtn address model ]
    ]
```

---

Refresh the browser and you should see the `Add Player` button on the top right. Clicking this button should trigger a POST request to the server, which will return a new player with an id. Then `CreatePlayerDone` will trigger and the browser location should change to the new player's edit view.

For reference, up to this point your application code should look like <https://github.com/sporto/elm-tutorial-app/tree/0600-add-player>.