> This page covers Tutorial v2. Elm 0.18.

# Players Commands

Next let's create the command to update the player through our API.

In __src/Commands.elm__ add:

```elm
import Json.Encode as Encode

...

savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    "http://localhost:4000/players/" ++ playerId


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes
```

### Save request

```elm
savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody ➊
        , expect = Http.expectJson playerDecoder ➋
        , headers = []
        , method = "PATCH" ➌
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }
```

➊ Here we encode the given player and then convert the encoded value to a JSON string
➋ Here we specify how to parse the response, in this case we want to parse the returned JSON back into an Elm value.
➌ `PATCH` is the http method that our API expects when updating records.

### Save

```elm
savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player ➊
        |> Http.send Msgs.OnPlayerSave ➋
```

Here we create the save request ➊ and then generate a command to send the request using `Http.send` ➋. 
`Http.send` takes a message constructor (`OnPlayerSave` in this case). After the request is done, Elm will trigger the `OnPlayerSave` message with the response for the request.


