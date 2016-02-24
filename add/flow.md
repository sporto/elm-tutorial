# Flow

Here is a diagram showing the flow of adding a player:

![Flow](flow-v04.png)

- From `Player.List` we trigger a `CreatePlayer` action
- This action will be picked up by `Players.Update`

