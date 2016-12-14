> Cette page couvre Elm 0.18

# Messages Main

Lorsque l'adresse du navigateur changera nous déclencherons un nouveau message.

Changez __src/Messages.elm__ en :

```elm
module Messages exposing (..)

import Navigation exposing (Location)
import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | OnLocationChange Location
```

- Nous avons importé `Navigation`
- Et nous avons ajouté un message `OnLocationChange Location`
