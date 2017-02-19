> This page covers Tutorial v2. Elm 0.18.

# Models

We want to store the response from the server in the models instead of the hardcoded list of players we have now.
In __src/Models.elm__, include a new import and change the type of `players`:

```elm
...

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    }


initialModel : Model
initialModel =
    { players = RemoteData.Loading
    }


...
```

- We changed the type of `players` from `List Player` to `WebData (List Player)`. This type `WebData` will contain the list of players when we get a successful response from the API.
- Our initial `players` attribute will be `RemoteData.Loading`, as it says this indicates that the resource is loading.