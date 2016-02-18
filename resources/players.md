# The Players resource

Let's create some content for our application. We will create a list of players. 

We will organise our application structure by the name of the resources in our application. Our application only has one resource `Players` So there will be only one sub-folder.  



The `Players` folder will have modules for the components of the Elm architeture, just like what we did with the main level:

- Players/Actions.elm
- Players/Models.elm
- Players/Update.elm

However, we will have different views for players: A list and a edit view. So these will be different modules:

- Players/List.elm
- Players/Edit.elm

## Players actions

Create __src/Players/Actions.elm__

```elm
module Players.Actions (..) where

import Http
import Players.Models exposing (PlayerId, Player)


type Action
  = NoOp
```

Here we will put all the actions related to players.

## Players Model

Create __src/Players/Models.elm__

```elm
module Players.Models (..) where


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

Here we define how a player record looks like, it has an id, a name and a level. 

Also note the definition for `PlayerId`, it is just an alias to `Int`, doing this is useful for clarity later on when we have function that take many ids. For example:

```elm
addPerkToPlayer : Int -> Int -> Player
```

is much clearer written as:

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```



## Players Update

As we have a Players.Model and Players.Action we should add a Players.Update as well, in this way we follow the Elm architecture.

Add __src/Players/Update.elm__

```elm
module Players.Update (..) where

import Effects exposing (Effects)
import Players.Actions exposing (..)
import Players.Models exposing (..)


type alias UpdateModel =
  { players : List Player
  }


update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
  ( model.players, Effects.none )
```

This update doesn't do anything at the moment. Also note how it follows the pattern of defining its own model `UpdateModel`, this will allow to pass more attributes later without having to change the function signature.

---

This is the basic pattern that all resources in our application will follow.

```
Players
    Actions
    Models
    Update
Perks
    Actions
    Models
    Update
...
```