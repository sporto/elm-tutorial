## Players Actions

First let's create an action for when the players are fetched from the API. Add a new import and action to __src/Players/Actions.elm__

```elm
...
import Http
import Players.Models exposing (PlayerId, Player)
import Hop

type Action
    ...
    | FetchAllDone (Result Http.Error (List Player))
```

Note the added `Player` in the import for `Players.Models`.

`FetchAllDone` will be called when we get the response from the server. This action will have a `Result` payload that will either contain an `Http.Error` or a list of players.

