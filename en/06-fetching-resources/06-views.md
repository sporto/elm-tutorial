> This page covers Tutorial v2. Elm 0.18.

# Views

After receiving the response back we store it in `players`. We now want to display the list of players.

The attribute `players` was a list of players before (`List Player`), now is `WebData (List Player`) type. Let's change __src/Players/List.elm__ to handle the new type of `players`.

Add `RemoteData` import

```elm
import RemoteData exposing (WebData)
```

Change `view` to:

```elm
view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]
```

Here we changed the signature and call a new function `maybeList`. Add `maybeList`:

```elm
maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)
```

This function uses a case expression to pattern match on the type of `response`. This types are provided by the `RemoteData` package. 

If `response` is of type `Success` we display the list of players. We call the previous `list` function we already had.