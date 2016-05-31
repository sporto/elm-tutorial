# Main model

In our main application model we want to store the current route and location.
Change __src/Models.elm__ to:

```elm
module Models exposing (..)

import Hop.Types exposing (Location)
import Players.Models exposing (Player)
import Routing


type alias Model =
    { players : List Player
    , routing : Routing.Model
    }


initialModel : Location -> Routing.Route -> Model
initialModel location route =
    { players = []
    , routing = Routing.Model location route
    }
```

Here we:

- added `routing` to the model
- changed `initialModel` so it takes a `location` and `route`
