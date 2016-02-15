# Fetching perks

For __perks__ and __perksPlayers__ we will follow the same pattern as players. 

## Perks Models

Add __src/Perks/Models.elm__:

```elm
module Perks.Models (..) where


type alias PerkId =
  Int


type alias Perk =
  { id : PerkId
  , name : String
  , bonus : Int
  , description : String
  }
```

## Perks Actions

__src/Perks/Actions.elm__:

```elm
module Perks.Actions (..) where

import Http
import Perks.Models exposing (Perk)


type Action
  = NoOp
  | FetchAll
  | FetchAllDone (Result Http.Error (List Perk))
  | TaskDone ()
```

## Perks Effects

## Perks Update

## PerksPlayers Models

/src/Perks/Models.elm

## PerksPlayers Actions

## PerksPlayers Effects

## PerksPlayers Update

## Main Actions

## Main Models

## Main Update

## Main

---




