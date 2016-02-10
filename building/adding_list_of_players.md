# Adding a list of players

Let's create some content for our application.

## Player actions

Create a file __src/Players/Actions.elm__

```elm
module Players.Actions (..) where

import Http
import Players.Models exposing (PlayerId, Player)


type Action
  = NoOp
```

