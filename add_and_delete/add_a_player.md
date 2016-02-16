# Add a player

Let's add a button to the players' list to create a new player.

## Players Actions

Add two new actions to __src/Players/Actions.elm__

```elm
  ...
  | CreatePlayer
  | CreatePlayerDone (Result Http.Error Player)
```

`CreatePlayer` will trigger the creation of a new player and `CreatePlayerDone` will be called when we get a return from the API.

## Players Effects

In __src/Players/Effects.elm__ add:

```elm
...
import Json.Encode as Encode

...

create : Player -> Effects Action
create player =
  let
    body =
      memberEncoder player
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = createUrl
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder
      |> Task.toResult
      |> Task.map CreatePlayerDone
      |> Effects.task


createUrl : String
createUrl =
  "http://localhost:4000/players"

```

`create` takes a `Player` record and returns an effect. At the moment there is no `post` function in the Http module so we need to use `send` instead. Read more about `send` [here](http://package.elm-lang.org/packages/evancz/elm-http/3.0.0/Http).

