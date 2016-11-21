> This page covers Elm 0.18

# Players messages

First let's create the messages we need for fetching players. Add a new import and message to __src/Players/Messages.elm__

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
```

`OnFetchAll` will be called when we get the response from the server. This message will carry a `Result` which can be either an `Http.Error` or the the list of fetched players.
