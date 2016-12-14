> Cette page couvre Elm 0.18

> This page covers Elm 0.17

# Modèle Main

Dans notre modèle d'application principal, on veut stocker la route actuelle.

Modifiez __src/Models.elm__ comme ceci :

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

Nous avons :

- ajouté `route` au modèle
- changé `initialModel` pour qu'il prenne une `route`
