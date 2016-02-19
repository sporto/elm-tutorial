# Actions and effects

We will add a couple of new actions for changing a player's level. In __src/Players/Actions.elm__ add:

```elm
  ...
  | ChangeLevel PlayerId Int
  | SaveDone (Result Http.Error Player)
```

- `ChangeLevel` will trigger when the user wants to change the level. The second parameter is an integer that indicates how much to change the level e.g. -1 to decrease or 1 to increase.
- `SaveDone` will be triggered after successfully saving the changed record on the API.