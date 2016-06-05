# Main

## Main Model

Remove the hardcoded list of players in __src/Models.elm__

```elm
initialModel : Model
initialModel =
    { players = []
    }
```

## Main

Finally, we want to run the `fetchAll` when starting the application.

Update __src/Main.elm__:

```elm
...
import Messages exposing (Msg(..))
...
import Players.Commands exposing(fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map PlayersMsg fetchAll )
```

Now `init` returns a list of commands to run when the application starts.
