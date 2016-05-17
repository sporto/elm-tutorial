# List over Maybe

Sometimes you need to find an item in a list and do something with it. For example return an effect to save a record to the server.

One initial approach could to try finding the item and crafting an effect just for it. This would involve having a Maybe in the case the item is not found on the list.

```elm
findItem id items =
  List.filter (\item -> item.id == id) items
    |> List.head
  
effectsToRun id items =
   case (findItem id items) of
    Maybe item ->
        effectFor item
    Nothing ->
        ... return no effect
```

In this snippet above we try to find one item in a list using `filter` and `head`. Then check if the items was found using a `case` expression and return an effect accordingly.

## Return lists instead

However, whenever possible structure your application to return a list instead, e.g. a list of tasks to run. When using `Effects` this is not necessary because `Effects` is already a collection of effects.

So instead of using a case statement we can just return a list:

```elm
effectsToRun id items =
  List.filter (\item -> item.id == id) items
    |> List.map (\item -> effectFor item)
```

Here we filter the items and return a list of effects to run, in this case we will have a list with one item, which is perfectly fine. 

The point is that we can avoid checking for `Maybe/Nothing` by just returning lists as much as we can.