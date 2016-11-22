> This page covers Elm 0.18

# Messages

Let's start by adding the messages we will need.

In __src/Players/Messages.elm__ add:

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
```

- `ChangeLevel` will trigger when the user wants to change the level. The second parameter is an integer that indicates how much to change the level e.g. -1 to decrease or 1 to increase.
- Then we will send a request to update the player to the API. `OnSave` will be triggered after the response from the API is received.
- `OnSave` will either carry the updated player on success or the Http error on failure.
