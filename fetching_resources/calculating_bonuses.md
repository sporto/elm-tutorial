# Calculating bonuses

Now that we are fetching all the resources we can properly calculate the bonuses for the players instead of hardcoding 999.

## PerksPlayers Utils

Let's add a few functions to calculate the bonuses for a player. Create a new module in __src/PerksPlayers/Utils.elm__:

<https://github.com/sporto/elm-tutorial-app/blob/0530-calc-bonuses/src/PerksPlayers/Utils.elm>

```elm
module PerksPlayers.Utils (..) where

import Players.Models exposing (PlayerId)
import Perks.Models exposing (PerkId, Perk)
import PerksPlayers.Models exposing (PerkPlayerId, PerkPlayer)


perkIdsForPlayerId : List PerkPlayer -> PlayerId -> List Int
perkIdsForPlayerId perksPlayers playerId =
  perksPlayers
    |> List.filter (\perkPlayer -> perkPlayer.playerId == playerId)
    |> List.map (\perkPlayer -> perkPlayer.perkId)


perksForPlayerId : List PerkPlayer -> List Perk -> PlayerId -> List Perk
perksForPlayerId perksPlayers perks playerId =
  let
    perkIds =
      perkIdsForPlayerId perksPlayers playerId

    included perk =
      List.any (\id -> id == perk.id) perkIds
  in
    perks
      |> List.filter included


bonusesForPlayerId : List PerkPlayer -> List Perk -> PlayerId -> Int
bonusesForPlayerId perksPlayers perks playerId =
  perksForPlayerId perksPlayers perks playerId
    |> List.foldl (\perk acc -> acc + perk.bonus) 0
```

- `perkIdsForPlayerId` returns a list of perk ids for a player.

- Using this list of ids, `perksForPlayerId` returns a list of perks for a player.

- And using this list of perks, `bonusesForPlayerId` returns the total bonus amount for a player.

## Players List

Let's call this function from __src/Players/List.elm__:

<https://github.com/sporto/elm-tutorial-app/blob/0530-calc-bonuses/src/Players/List.elm>

Add some imports:

```elm
...
import Perks.Models exposing (Perk)
import PerksPlayers.Models exposing (PerkPlayer)
import PerksPlayers.Utils exposing (bonusesForPlayerId)
```

Add `perks` and `perksPlayers` to the `ViewModel`:

```elm
type alias ViewModel =
  { players : List Player
  , perks : List Perk
  , perksPlayers : List PerkPlayer
  }
```

And call the `bonusesForPlayerId` function:

```elm
playerRow : Signal.Address Action -> ViewModel -> Player -> Html.Html
playerRow address model player =
  let
    bonuses =
      bonusesForPlayerId model.perksPlayers model.perks player.id

    strength =
      bonuses + player.level
  in
    ...
```

## Players Edit

Let's add the bonuses to the player edit view as well:



---

If you refresh you should see the calculated bonuses in the players' list and a player's edit view.


