> This page covers Elm 0.18

# Players commands

Now we need to create the tasks and command to fetch the players from the server. Create __src/Players/Commands.elm__:

```elm
module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```

Also update __src/Players/Models.elm__ to match the types in the Json:

```
...
type alias PlayerId = String
...
new : Player
new =
  { id = "0"
  , name = ""
  , level = 1
  }
```

And __src/Players/List.elm__ to render the `player.id` correctly:

```
playerRow : Player -> Html Msg
playerRow player =
  tr []
     [ td [] [ text player.id ]
     , td [] [ text player.name ]
     , td [] [ text (toString player.level) ]
     , td [] []
     ]
```
---

Let's go through this code.

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll
```

Here we create a command for our application to run.

- `Http.get` creates a `Request`
- We then send this request to `Http.send` which wraps it in a command

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

This decoder delegates the decoding of each member of a list to `memberDecoder`

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```

`memberDecoder` creates a JSON decoder that returns a `Player` record.

---
To understand how the decoder works let's play with the Elm repl.

In a terminal run `elm repl`. Import the Json.Decoder module:

```bash
> import Json.Decode exposing (..)
```

Then define a Json string:

```bash
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

And define a decoder to extract the `id`:

```bash
> idDecoder = (field "id" int)
```

This creates a decoder that given a string tries to extract the `id` key and parse it into a integer.

Run this decoder to see the result:

```bash
> result = decodeString idDecoder  json
Ok 99 : Result.Result String Int
```

We see `Ok 99` meaning that decoding was successful and we got 99. So this is what `(field "id" Decode.int)` does, it creates a decoder for a single key.

This is one part of the equation. Now for the second part, define a type:

```bash
> type alias Player = { id: Int, name: String }
```

In Elm you can create a record calling a type as a function. For example, `Player 1 "Sam"` creates a player record. Note that the order of parameters is significant like any other function.

Try it:

```bash
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

With these two concepts let's create a complete decoder:

```bash
> nameDecoder = (field "name" string)
> playerDecoder = map2 Player idDecoder nameDecoder
```

`map2` takes a function as first argument (Player in this case) and two decoders. Then it runs the decoders and passes the results as the arguments to the function (Player).

Try it:
```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

Remember that none of this actually executes until we send the command to __program__.
