# Flow

Here is a diagram showing the flow of adding a player:

![Flow](flow-v04.png)

- From `Player.List` we trigger a `CreatePlayer` action (1)
- This action will be picked up by `Players.Update` returning a `create` effect
- `port runner` runs the `create` effect sending a request to the API
- When the response comes back the effect triggers the `CreatePlayerDone` action
- `Player.Update` reacts to `CreatePlayerDone` by updating the players collection
- StartApp renders the application with the updated collection

