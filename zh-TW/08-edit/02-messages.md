# Messages

Let's start by adding the messages we will need.

In __src/Players/Messages.elm__ add:

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | SaveSuccess Player
    | SaveFail Http.Error
```

- `ChangeLevel` will trigger when the user wants to change the level. The second parameter is an integer that indicates how much to change the level e.g. -1 to decrease or 1 to increase.
- Then we will send a request to update the player to the API. `SaveSuccess` will be triggered after a successful response from the API, and `SaveFail` on case of failure.
