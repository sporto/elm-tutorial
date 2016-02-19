# Players Effects

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

### saveTask

- Encodes the given player
- Creates a task to send the encoded player to the API
- And also decodes the response given by the API

### save

- Takes the `saveTask` and converts the response to a `Result` type
- Then it wraps the result with `SaveDone` type
- And converts the task to an `Effect` 

