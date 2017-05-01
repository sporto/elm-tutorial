> Cette page couvre Elm 0.18

# Modules Joueurs

## Messages Joueurs

Créez __src/Players/Messages.elm__ :

```elm
module Players.Messages exposing (..)


type Msg
    = NoOp
```

C'est là que nous mettrons tous les messages relatifs aux joueurs.

## Modèles Joueurs

Créez __src/Players/Models.elm__ :

```elm
module Players.Models exposing (..)


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


new : Player
new =
    { id = "0"
    , name = ""
    , level = 1
    }
```

C'est là que nous définissons à quoi ressemble un enregistrement de joueur : il se compose d'un identifiant (`id`), d'un nom (`name`) et d'un niveau (`level`).

Notez aussi la définition d'un `PlayerId` : il s'agit juste d'un `String`, mais cette définition nous sert à clarifier le sens des fonctions qui prendront plusieurs `Int`. Ainsi, la fonction :

```elm
addPerkToPlayer : Int -> Int -> Player
```

sera bien plus claire écrite comme cela :

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## Mise à jour Joueurs

Créez __src/Players/Update.elm__ :

```elm
module Players.Update exposing (..)

import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        NoOp ->
            ( players, Cmd.none )
```

Cette fonction de mise à jour n'a pour le moment aucun effet.
---

C'est ce schéma de base que suivent toutes les ressources dans une grande application :

```
Messages
Models
Update
Players
    Messages
    Models
    Update
Perks
    Messages
    Models
    Update
...
```
