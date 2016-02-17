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


delete : PlayerId -> Effects Action
delete playerId =
  deleteTask playerId
    |> Task.toResult
    |> Task.map (DeletePlayerDone playerId)
    |> Effects.task
```

### deleteTask

`deleteTask` takes a player id and returns a task to delete the player.

`Http.send` returns a task of type `Task.Task Http.RawError Http.Response`. But for consistency with other functions we want `Task.Task Http.Error a`

## Players List

## Players Update

## Main

## Mailbox

## Update

## index.js
