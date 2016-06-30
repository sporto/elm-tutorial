# Players messages

First let's create the messages we need for fetching players. Add a new import and message to __src/Players/Messages.elm__

```elm
...
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
```

`FetchAllDone` will be called when we get the response from the server. This message will carry the list of fetched players.

`FetchAllFail` will be called if there is a problem fetching the data.

