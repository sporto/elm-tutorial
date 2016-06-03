# Plan

The next step is to fetch the list of player from the fake API we created before.

This is the plan:

![Plan](01-plan.png)

(1-2) When the application loads, we trigger a command to initiate an Http request to fetch the players. This will be done in the `init` of Html.App.

(3-6) When the request is done, we trigger a `FetchAllDone` with the data, this message flows down to `Players.Update` which updates the collection of players.

(7-10) Then the application renders with the updated player list.

## Dependencies

We will need the `http`, install it using:

```
elm package install evancz/elm-http
```
