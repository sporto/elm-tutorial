# Fetching players



## Main Model

Remove the hardcoded list of players in __src/Model.elm__

```elm
initialModel : AppModel
initialModel =
  { players = []
  , routing = Routing.initialModel
  }
```



## Players Effects

Now we need to create the tasks and effects to fetch the players from the server. Create __src/Players/Effects.elm__:

```elm
module Players.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Actions exposing (..)


fetchAll : Effects Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map FetchAllDone
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

`memberDecoder` creates a JSON decoder that returns a `Player` record. 

---
To understand how the decoder works let's play with the elm repl.

In a terminal run `elm repl`. Import the Json.Decoder module:

```elm
> import Json.Decode exposing (..)
```

Then define a Json string:

```elm
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

And define a decoder to extract the `id`:

```
> idDecoder = ("id" := int)
```

This creates a decoder that given a string tries to extract the `id` key and parse it into a integer.

Run this decoder to see the result:

```
> result = decodeString idDecoder  json
Ok 99 : Result.Result String Int
```

We see `Ok 99` meaning that decoding was successful and we got 99. So this is what `("id" := Decode.int)` does, it creates a decoder for a single key. 

This is one part of the equation. Now for the second part, define a type:

```
> type alias Player = { id: Int, name: String }
```

In Elm you can create a record calling a type as a function. Foe example `Player 1 "Sam"` creates a player record. Note that the order of parameters is important as any other function. 

Try it:

```
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

With these two concepts let's create a complete decoder:

```elm
> nameDecoder = ("name" := string)
> playerDecoder = object2 Player idDecoder nameDecoder
```

`object2` takes a function as first argument (Player in this case) and two decoders. Then it runs the decoders and passes the results as the arguments to the function (Player).

Try it:
```elm
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---


Then `collectionDecoder` applies `memberDecoder` to each record on a JSON array. 

And we have `fetchAll`:

```elm
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map FetchAllDone
    |> Effects.task
```

`Http.get` takes a decoder and a url string. Then it:
- creates a task that makes an ajax request
- when done parses the result body through the decoder
- and returns another task with result `Task.Task Http.Error value`

Remember that none of this actually executes until it is send to a port.

- In `Task.toResult` we convert this `Task.Task Http.Error value` to a task that resolves with a `Result`. At this point the result of the task would be `Result Http.Error value`

- Then we map this task to `FetchAllDone`. So now the result of the task would be `FetchAllDone (Result Http.Error value)`.

- And lastly we convert the task to an effect.

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

Your application code should look at this stage like <https://github.com/sporto/elm-tutorial-app/tree/0500-fetch-players>.