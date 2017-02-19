> This page covers Tutorial v2. Elm 0.18.

# Main model

In our main application model we want to store the current route.
In __src/Models.elm__, change `Model` and `initialModel` to:

```elm
...

type alias Model =
    { players : WebData (List Player)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    }
```

Here we:

- added `route` to the model
- changed `initialModel` so it takes a `route`
