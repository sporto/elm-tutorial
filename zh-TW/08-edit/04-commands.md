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
                |> Encode.encode 0 ➋
                |> Http.string ➌

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl player.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config ➍
            |> Http.fromJson memberDecoder ➎
```

➊ Encodes the given player, converting the record to a `Value`. A `Value` in this context is a type that encapsulates a JavaScript value (number, string, null, boolean, array, object).

➋ `Encode.encode` converts the `Value` to a Json string.
Similar to `JSON.stringify` in JavaScript. `0` indicates the indentation on the resulting string.
<http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Json-Encode#encode>

➌ Creates a Http request body using the given string. <http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#string>

➍ Creates a task to send the encoded player to the API.
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#send>

➎ This takes the previous task and chains it with a new task that will decode the response given by the API and give us the decoded value.
<http://package.elm-lang.org/packages/evancz/elm-http/3.0.1/Http#fromJson>

### Save

```elm
save : Player -> Cmd Msg
save player =
    saveTask player ➊
        |> Task.perform ➋ SaveFail SaveSuccess
```

Takes the `saveTask` ➊ and converts it to a command using `Task.perform` ➋. This command will resolve on the `SaveFail` message on failure or `SaveSuccess` message on success.


