> Cette page couvre Elm 0.18

# Main

Le programme principal doit être branché au module Joueurs que nous avons créé.

Il nous faut créer les liens suivants :

```elm
Main Messages  --->    Players Messages
Main Models    --->    Players Models
Main Update    --->    Players Update
```

## Messages Main

Modifiez __src/Messages.elm__ pour inclure les messages Joueurs :

```elm
module Messages exposing (..)

import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
```

## Modèles Main

Modifiez __src/Models.elm__ pour inclure les Joueurs :

```elm
module Models exposing (..)

import Players.Models exposing (Player)


type alias Model =
    { players : List Player
    }


initialModel : Model
initialModel =
    { players = [ Player "1" "Sam" 1 ]
    }
```

Pour l'instant, nous avons codé un joueur en dur.

## Mise à jour Main

Modifiez __src/Update.elm__ comme ceci :

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, cmd ) =
                    Players.Update.update subMsg model.players
            in
                ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
```

Nous suivons bien l'architecture Elm :

- tous les `PlayersMsg` sont redirigés vers `Players.Update`.
- on extrait le résultat pour `Players.Update` grâce au filtrage par motif (*pattern matching*)
- on retourne le modèle avec la liste des joueurs mise à jour et les commandes qui doivent être exécutées.
