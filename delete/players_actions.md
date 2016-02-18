# Players Actions

Add the following actions to __src/Players/Actions.elm:

<https://github.com/sporto/elm-tutorial-app/blob/500-delete-player/src/Players/Actions.elm>

```elm
...
  | DeletePlayerIntent Player
  | DeletePlayer PlayerId
  | DeletePlayerDone PlayerId (Result Http.Error ())
```

- `DeletePlayerIntent` will trigger when hitting the Delete button, we pass the whole player record so we can grab the `id` and the `name` later

- `DeletePlayer` will trigger after the user confirms their intention to delete the player, we just need the player id

- `DeletePlayerDone` will trigger after the delete request to the server. This action has to arguments the playerId and the result from the server. We don't need the actual body from the response so we use `()`. As long as the result is `Ok` we will know that the deletion was successful.