# Delete a player

Deleting a player will follow the same pattern than adding a player but with one complication: we want to show a conformation dialogue before removing the player.

The steps for this will be:

- When the user clicks the delete button trigger an action (`DeletePlayerIntent`) with the intention of delete the player
- This action will trigger a call to a port that sends a message to JavaScript
- JavaScript listens to this port and shows a window confirmation dialogue
- If the user clicks yes we send a message to Elm via another port
- This inbound port triggers an action `DeletePlayer`
- This action triggers the actual deletion

## Players Actions

Add the following actions to __src/Players/Actions.elm:

<https://github.com/sporto/elm-tutorial-app/blob/0610-delete-player/src/Players/Actions.elm>

```elm
...
  | DeletePlayerIntent Player
  | DeletePlayer PlayerId
  | DeletePlayerDone PlayerId (Result Http.Error ())
```

- `DeletePlayerIntent` will trigger when hitting the Delete button, we pass the whole player record so we can grab the `id` and the `name` later

- `DeletePlayer` will trigger after the user confirms their intention to delete the player, we just need the player id

- `DeletePlayerDone` will trigger after the delete request to the server. This action has to arguments the playerId and the result from the server. We don't need the actual body from the response so we use `()`. As long as the result is `Ok` we will know that the deletion was successful.

## Players List

In __src/Players/List.elm__ we want to have a button that triggers `DeletePlayerIntent`.

Add a new function:

```elm
deleteBtn : Signal.Address Action -> Player -> Html.Html
deleteBtn address player =
  button
    [ class "btn regular mr1"
    , onClick address (DeletePlayerIntent player)
    ]
    [ i [ class "fa fa-trash mr1" ] [], text "Delete" ]
```

This renders a button that when clicked sends the `DeletePlayerIntent` action with the player as payload to the StartApp address.

## Players Effects

Next, add the effects to delete the player. Add this to __src/Players/Effects.elm__:

```elm
deleteUrl : PlayerId -> String
deleteUrl playerId =
  "http://localhost:4000/players/" ++ (toString playerId)


deleteTask : PlayerId -> Task.Task Http.Error ()
deleteTask playerId =
  let
    config =
      { verb = "DELETE"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = deleteUrl playerId
      , body = Http.empty
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson (Decode.succeed ())
```

`deleteTask` takes a player id and returns a task to delete the player.

`Http.send` returns a task of type `Task.Task Http.RawError Http.Response`. But for consistency with other effects we want `Task.Task Http.Error a` where `a` is the parsed JSON.

`Http.fromJson decoder` will parse the returned body into Json and return a type of type `Task.Task Http.Error a` which is what we want. We don't care about the returned body so we use `(Decode.succeed ())` as the decoder. This is a decoder that always succeeds and returns empty. 

So here we are using `Http.fromJson` just for the side effect of converting the task to `Task.Task Http.Error ()`.

In the same file also add:

```elm
delete : PlayerId -> Effects Action
delete playerId =
  deleteTask playerId
    |> Task.toResult
    |> Task.map (DeletePlayerDone playerId)
    |> Effects.task
```

This takes the previous `deleteTask`, converts the result of the task to a `Result` type. Then wraps the result with the `DeletePlayerDone` action and finally converts it to an effect.

## Players Update

## Main

## Mailbox

## Update

## index.js
