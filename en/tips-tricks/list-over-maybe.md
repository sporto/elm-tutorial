# List over Maybe

Sometimes you need to find an item in a list and do something with it. For example return a command to save a record to the server.

One initial approach could be trying to find the item and returning a Maybe:

```elm
findItem id items =
    List.filter (\item -> item.id == id) items
        |> List.head
```

Later on you will need to pattern match with that Maybe:

```elm
commandsToRun id items =
    case (findItem id items) of
        Maybe item ->
            commandFor item
        Nothing ->
            ... return no command
```

## Return lists instead

Instead, whenever possible return a list, e.g. a list of one or zero users. Later you can map over that list to do something else:

```elm
commandsToRun items =
    List.map commandFor items
```

Here we return a list of commands to run.

The point is that we can postpone checking for `Maybe/Nothing` as much as possible by returning lists instead.
