# Add a player

Let's add a button to the players' list to create a new player.

## Players Actions

First, add two new actions to __src/Players/Actions.elm__

```elm
  ...
  | CreatePlayer
  | CreatePlayerDone (Result Http.Error Player)
```

- `CreatePlayer` will trigger the creation of a new player 
- `CreatePlayerDone` will be called when we get a return from the API.


