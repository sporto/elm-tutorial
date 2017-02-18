> This page covers Tutorial v2. Elm 0.18.

## Players Model

Change __src/Models.elm__ to:

```elm
module Models exposing (..)


type alias Model =
    { players : List Player
    }


initialModel : Model
initialModel =
    { players = [ Player "1" "Sam" 1 ]
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
```

Here we define how a player record looks. It has an id, a name and a level.

Also note the definition for `PlayerId`, it is just an alias to `String`, doing this is useful for clarity later on when we have function that takes many ids. For example:

```elm
addPerkToPlayer : Int -> String -> Player
```

is much clearer when written as:

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

We also added `players` to our main model and created a hardcoded list for now.

