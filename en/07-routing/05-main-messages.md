> This page covers Tutorial v2. Elm 0.18.

# Main messages

When the browser location changes we will trigger a new message.

Change __src/Messages.elm__ to:

```elm
module Messages exposing (..)

import Navigation exposing (Location)
import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | OnLocationChange Location
```

- We are now importing `Navigation`
- And we added a `OnLocationChange Location` message