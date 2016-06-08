# Main model

In our main application model we want to store the current route.
Change __src/Models.elm__ to:

```elm
module Models exposing (..)

import Players.Models exposing (Player)
import Routing


type alias Model =
    { players : List Player
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { players = []
    , route = route
    }
```

Here we:

- added `route` to the model
- changed `initialModel` so it takes a `route`
