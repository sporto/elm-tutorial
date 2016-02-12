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

`memberDecoder` creates a Json decoder that returns a `Player` record. 

TODO explain how it works
- object3 applies a function, the function is Player

`collectionDecoder` applies `memberDecoder` to each record on the Json array. 

And we have `fetchAll`:

```elm
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task
```

`Http.get` takes a decoder and a url string. It:
- creates a task that makes an ajax request
- when done parses the result body through the decoder
- and returns another task with result `Task.Task Http.Error value`

Remember that none of this actually executes until it is send to a port.

- In `Task.toResult` we convert this `Task.Task Http.Error value` to a task that resolves with a `Result`. At this point the result of the task would be `Result Http.Error value`
- Then we map this task to `FetchAllDone`. So at this point the result of the task would be `FetchAllDone (Result Http.Error value)`.



## Main

Finally we need to run the `fetchAll` when starting the application.

Update __src/Main.elm__:

```elm
...
import Players.Effects

init =
  let
    fxs =
      [ Effects.map PlayersAction Players.Effects.fetchAll
      ]

    fx =
      Effects.batch fxs
  in
    ( Models.initialModel, fx )
```

`init` now returns a list of effects to run when the application starts. For now is a list of one but we will adding more to this list soon. `Effects.batch` batches a list of effects into one `Effects`.

---

Try it! Refresh the browser, our application should now fetch the list of players from the server.

Your application code should look at this stage like <https://github.com/sporto/elm-tutorial-app/tree/170-fetch-players>.