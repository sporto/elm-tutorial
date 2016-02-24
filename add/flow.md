# Flow

Here is a diagram showing the flow of adding a player:

![Flow](flow-v04.png)

- From `Player.List` we trigger a `CreatePlayer` action (1)
- This action will be picked up by `Players.Update` returning a `create` effect (3)
- `port runner` runs the `create` effect sending a request to the API (6)
- When the response comes back the effect triggers the `CreatePlayerDone` action (8)
- `Player.Update` reacts to `CreatePlayerDone` by updating the players collection (9)
- StartApp renders the application with the updated collection (12)

