# Plan

The next step is to fetch the list of player from the fake api we set up before.

This is the plan:

- When the application loads include an effect to initiate an Http request to the API to fetch the players. This will be done in the `init` of StartApp.

- When the request is done trigger a `FetchAllDone` with the result of the request.

- 