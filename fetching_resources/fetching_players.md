# Fetching players

The next step is to fetch the list of player from the fake api we set up before.

## Main Model

Remove the hardcoded list of players in __src/Model.elm__

```elm
initialModel : AppModel
initialModel =
  { players = []
  , routing = Routing.initialModel
  }
```

## Players Actions

Add a new import and action to __src/Players/Actions.elm__

```elm
...
import Http

type Action
    ...
    | FetchAllDone (Result Http.Error (List Player))
```

`FetchAllDone` will be called when we get the response from the server. This action will have a `Result` payload that will either contain an `Http.Error` or a list of players.

## Players Update

__src/Players/Update.elm__ should account for this new action. Add a new branch to the case expression:

```elm
  case action of
    ...
    FetchAllDone result ->
      case result of
        Ok players ->
          ( players, Effects.none )

        Err error ->
          ( model.players, Effects.none )
```

We pattern match a successful response with `Ok players`. The successful result payload has the fetched players, so we return that payload to update the players collection.

`Err error` matches the case of an error. We will deal with that in the next chapter, for now we just return what we had before.

## Players Effects

Now we need to create the tasks and effects to fetch the players from the server. Create __src/Players/Effects.elm__:

```elm
module Players.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Actions as Actions


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/players"



-- DECODERS


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
  Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
  Decode.object3
    Player
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("level" := Decode.int)
```

## Main

---

Try it! Refresh the browser, our application should now fetch the list of players from the server.

Your application code should look at this stage like <https://github.com/sporto/elm-tutorial-app/tree/170-fetch-players>.