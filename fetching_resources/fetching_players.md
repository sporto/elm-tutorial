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



## Main