# Players modules

## Players messages

Create __src/Players/Messages.elm__

```elm
module Players.Messages exposing (..)


type Msg
    = NoOp
```

Here we will put all the messages related to players.

## Players Model

Create __src/Players/Models.elm__

```elm
module Players.Models exposing (..)


type alias PlayerId =
    Int


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


new : Player
new =
    { id = 0
    , name = ""
    , level = 1
    }
```

Here we define how a player record looks. It has an id, a name and a level.

Also note the definition for `PlayerId`, it is just an alias to `Int`, doing this is useful for clarity later on when we have function that takes many ids. For example:

```elm
addPerkToPlayer : Int -> Int -> Player
```

is much clearer when written as:

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## Players Update

Add __src/Players/Update.elm__

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

This update doesn't do anything at the moment.
---

This is the basic pattern that all resources in a bigger application would follow:

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
