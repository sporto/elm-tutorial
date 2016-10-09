# Main

## Modèle Main

Enlevez la liste des Joueurs codée en dur dans __src/Models.elm__ :

```elm
initialModel : Model
initialModel =
    { players = []
    }
```

## Main

Pour finir, on veut exécuter `fetchAll` quand l'application démarre.

Changez __src/Main.elm__ comme suit :

```elm
...
import Messages exposing (Msg(..))
...
import Players.Commands exposing (fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map PlayersMsg fetchAll )
```

Désormais, `init` retourne une liste de commandes à exécuter lorsque l'application démarre.
