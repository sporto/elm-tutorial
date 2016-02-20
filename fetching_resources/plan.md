# Plan

The next step is to fetch the list of player from the fake API we set up before.

This is the plan:


![](flow-v01.png)

- When the application loads include an effect to initiate an Http request to the API to fetch the players. This will be done in the `init` of StartApp.

- When the request is done trigger a `FetchAllDone` with the result of the request.

- Add a branch to Players Update so it reacts to `FetchAllDone` and adds the fetched players to the application model.

- Then the application renders with the updated player list.
