# Actions and effects

We will add a couple of new actions for changing a player's level. In __src/Players/Actions.elm__ add:

```elm
  ...
  | ChangeLevel PlayerId Int
  | SaveDone (Result Http.Error Player)
```

- `ChangeLevel` will trigger when the user wants to change the level. The second parameter is an integer that indicates how much to change the level e.g. -1 to decrease or 1 to increase.
- Then we will send a request to update the player to the API. `SaveDone` will be triggered after we get the response from the API.

## Players Effects

Next let's create an effect to save an updated player through our API.

In __src/Players/Effects.elm__ add:

```elm
saveUrl : Int -> String
saveUrl playerId =
  "http://localhost:4000/players/" ++ (toString playerId)
  
saveTask : Player -> Task.Task Http.Error Player
saveTask player =
  let
    body =
      memberEncoded player
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "PATCH"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = saveUrl player.id
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder


save : Player -> Effects Action
save player =
  saveTask player
    |> Task.toResult
    |> Task.map SaveDone
    |> Effects.task
```

### `saveTask`

- encodes the given player
- 