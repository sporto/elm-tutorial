# Showing Errors 3

In the previous section we required a `showErrorAddress` in Players.Update.

We need to provide this address and do map it to the main action we want (`ShowError`).

## Auxiliary mailbox

Unfortunately StartApp doesn't give a mechanism to send messages to its address from `update`. 