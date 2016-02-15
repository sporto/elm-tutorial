# Fetching perks

For __perks__ and __perksPlayers__ we will follow the same pattern as players. 

## Perks Models

Add __src/Perks/Models.elm__

<https://github.com/sporto/elm-tutorial-app/blob/0520-fetch-rest/src/Perks/Models.elm>

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

__src/Perks/Actions.elm__

<https://github.com/sporto/elm-tutorial-app/blob/0520-fetch-rest/src/Perks/Actions.elm>

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

__src/Perks/Effects.elm__

<https://github.com/sporto/elm-tutorial-app/blob/0520-fetch-rest/src/Perks/Effects.elm>

```elm
module Perks.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Perks.Models exposing (Perk)
import Perks.Actions as Actions


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/perks"



-- DECODERS


collectionDecoder : Decode.Decoder (List Perk)
collectionDecoder =
  Decode.list memberDecoder


memberDecoder : Decode.Decoder Perk
memberDecoder =
  Decode.object4
    Perk
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("bonus" := Decode.int)
    ("description" := Decode.string)
```

## Perks Update

__src/Perks/Update.elm__

<https://github.com/sporto/elm-tutorial-app/blob/0520-fetch-rest/src/Perks/Update.elm>

```elm
module Perks.Update (..) where

import Effects exposing (Effects)
import Perks.Actions exposing (..)
import Perks.Models exposing (Perk)


type alias UpdateModel =
  { perks : List Perk
  , showErrorAddress : Signal.Address String
  }


update : Action -> UpdateModel -> ( List Perk, Effects Action )
update action model =
  case action of
    FetchAllDone result ->
      case result of
        Ok perks ->
          ( perks, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.perks, fx )

    _ ->
      ( model.perks, Effects.none )
```

Just like in the Players.Update module we send a message to `showErrorAddress` in case of an error.

## PerksPlayers Models

__/src/PerksPlayers/Models.elm__:

```elm
module PerksPlayers.Models (..) where

import Players.Models exposing (PlayerId)
import Perks.Models exposing (PerkId)


type alias PerkPlayerId =
  Int


type alias PerkPlayer =
  { id : PerkPlayerId
  , perkId : PerkId
  , playerId : PlayerId
  }

```

## PerksPlayers Actions

__src/PerksPlayers/Actions.elm__:

```elm
module PerksPlayers.Actions (..) where

import Http
import PerksPlayers.Models exposing (PerkPlayer)


type Action
  = NoOp
  | FetchAll
  | FetchAllDone (Result Http.Error (List PerkPlayer))
  | TaskDone ()
```

## PerksPlayers Effects

__/src/PerksPlayers/Effects.elm__:

```elm
module PerksPlayers.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import PerksPlayers.Models exposing (PerkPlayer)
import PerksPlayers.Actions as Actions


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/perks_players"



-- DECODERS


collectionDecoder : Decode.Decoder (List PerkPlayer)
collectionDecoder =
  Decode.list memberDecoder


memberDecoder : Decode.Decoder PerkPlayer
memberDecoder =
  Decode.object3
    PerkPlayer
    ("id" := Decode.int)
    ("perkId" := Decode.int)
    ("playerId" := Decode.int)

```

## PerksPlayers Update

__/src/PerksPlayers/Update.elm__:

```elm
module PerksPlayers.Update (..) where

import Effects exposing (Effects)
import PerksPlayers.Actions exposing (..)
import PerksPlayers.Models exposing (PerkPlayerId, PerkPlayer)


type alias UpdateModel =
  { perksPlayers : List PerkPlayer
  , showErrorAddress : Signal.Address String
  }


update : Action -> UpdateModel -> ( List PerkPlayer, Effects Action )
update action model =
  case action of
    FetchAllDone result ->
      case result of
        Ok perksPlayers ->
          ( perksPlayers, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.perksPlayers, fx )

    _ ->
      ( model.perksPlayers, Effects.none )
```

## Main Actions

## Main Models

## Main Update

## Main

---


This is how your application code should look at this point <https://github.com/sporto/elm-tutorial-app/tree/0520-fetch-rest>.



