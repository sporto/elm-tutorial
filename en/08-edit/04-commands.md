> This page covers Tutorial v2. Elm 0.18.

# Players Commands

Next let's create the command to updated the player through our API.

In __src/Players/Commands.elm__ add:

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### Save request

```elm
saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody ➊
        , expect = Http.expectJson memberDecoder ➋
        , headers = []
        , method = "PATCH" ➌
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }
```

➊ Here we encode the given player and then convert the encoded value to a JSON string
➋ Here we specify how to parse the response, in this case we want to parse the returned JSON back into an Elm value.
➌ `PATCH` is the http method that our API expects when updating records.

### Save

```elm
save : Player -> Cmd Msg
save player =
    saveRequest player ➊
        |> Http.send OnSave ➋
```

Here we create the save request ➊ and then generate a command to send the request using `Http.send` ➋. 
`Http.send` takes a message constructor (`OnSave` in this case). After the request is done, Elm will trigger the `OnSave` message with the response for the request.


