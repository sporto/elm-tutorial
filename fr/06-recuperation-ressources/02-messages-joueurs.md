> Cette page couvre Elm 0.18

# Messages Joueurs

D'abord, créons les messages dont nous avons besoin pour récupérer les Joueurs. Ajoutez un nouvel import et un nouveau message à __src/Players/Messages.elm__ :

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
```

`OnFetchAll` sera appelé lorsque nous recevrons une réponse du serveur. Ce message contiendra un `Result`, qui sera ou un `Http.Error` ou la liste des joueurs récupérée.
