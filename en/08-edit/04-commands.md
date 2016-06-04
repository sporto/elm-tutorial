# Players Commands

Next let's create tasks and commands to save an updated player through our API.

In __src/Players/Commands.elm__ add:

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
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


save : Player -> Cmd Msg
save player =
    saveTask player
        |> Task.perform SaveFail SaveSuccess


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.int player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### Save task

```elm
saveTask : Player -> Task.Task Http.Error Player
saveTask player =
    let
        body =
            memberEncoded player ➊
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl player.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config ➋
            |> Http.fromJson memberDecoder ➌
```

- ➊ Encodes the given player 
- ➋ Creates a task to send the encoded player to the API
- ➌ And decodes the response given by the API

### Save

```elm
save : Player -> Cmd Msg
save player =
    saveTask player ➊
        |> Task.perform ➋ SaveFail SaveSuccess
```

Takes the `saveTask` ➊ and converts it to a command using `Task.perform` ➋. This command will resolve on the `SaveFail` message on failure or `SaveSuccess` message on success.


