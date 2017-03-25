> This page covers Tutorial v2. Elm 0.18.

# Commands

Now we need a command to fetch the players from the server. Create __src/Commands.elm__:

```elm
module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PlayerId, Player)
import RemoteData


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/players"


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
```
---

Let's go through this code.

```elm
fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder ➊
        |> RemoteData.sendRequest ➋
        |> Cmd.map Msgs.OnFetchPlayers ➌
```

Here we create a command for our application to run.

- ➊ `Http.get` takes a url and a decoder. This returns a `Request` type.
- ➋ We pass this request to `RemoteData.sendRequest`, this function will wrap the request in a `WebData` type and return a `Cmd` to send the request.
- ➌ We map the command from `RemoteData` to `OnFetchPlayers`. In that way we can handle the response in our update.

```elm
playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder
```

This decoder delegates the decoding of each member of a list to `playerDecoder`

```elm
playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
```

`playerDecoder` creates a JSON decoder that returns a `Player` record. Here we use `decode` and `required` from the JSON Pipeline package. This package allows to decode JSON in a more intuitive way than doing it without any packages.

Remember that none of this actually executes until we send the command to __program__.

--- 

Now that we have a command to fetch players we need to call it.

In __src/Main.elm__ call this command in `init`:

```elm

...
import Commands exposing (fetchPlayers)


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchPlayers )
```

Here we import `fetchPlayers` and call this in `init`. This tells `Html.program` to run this request when the application starts.
