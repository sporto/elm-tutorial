# Player Edit: Actions, Model and Update

## Players Actions

We need a new Players action to trigger a location change to the player edit view. Change __src/Players/Actions.elm__ to:

```elm
module Players.Actions (..) where

import Hop
import Players.Models exposing (PlayerId, Player)


type Action
  = NoOp
  | EditPlayer PlayerId
  | HopAction Hop.Action
```

We will trigger `EditPlayer` whenever we want to edit a player.