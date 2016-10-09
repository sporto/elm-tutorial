# Messages Joueurs

D'abord, créons les messages dont nous avons besoin pour récupérer les Joueurs. Ajoutez un nouvel import et un nouveau message à __src/Players/Messages.elm__ :

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
```

`FetchAllDone` sera appelé quand nous obtiendrons la réponse du serveur. Ce message transportera la liste des Joueurs récupérée.

`FetchAllFail` sera appelé s'il y a un problème avec la récupération des données.
