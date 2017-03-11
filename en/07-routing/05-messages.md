> This page covers Tutorial v2. Elm 0.18.

# Messages

When the browser location changes we will trigger a new `OnLocationChange` message.

Change __src/Msgs.elm__ to:

```elm
module Msgs exposing (..)

import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
```

- We are now importing `Navigation`
- And we added a `OnLocationChange Location` message