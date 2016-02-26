# Players Update


When the request for players is done we trigger the `FetchAllDone` action.

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