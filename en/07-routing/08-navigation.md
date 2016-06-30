# Navigation

Next let's add buttons to navigate between views.

## EditPlayer message

Change __src/Players/Messages.elm__ to include two new actions:

```elm
...

type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | ShowPlayers
    | ShowPlayer PlayerId
```

We added `ShowPlayers` and `ShowPlayer`.

## Players List

The players' list needs to show a button for each player to trigger the `ShowPlayer` message.

In __src/Players/List.elm__. First add `Html.Events`:

```elm
import Html.Events exposing (onClick)
```

Add a new function for this button at the end:

```elm
editBtn : Player -> Html.Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

Here we trigger `ShowPlayer` with the id of the player that we want to edit.

And change `playerRow` to include this button:

```elm
playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player ]
        ]
```

## Player Edit

Let's add the navigation button to the edit view. In __/src/Players/Edit.elm__:

Add one more import:

```elm
import Html.Events exposing (onClick)
```

Add a new function at the end for the list button:

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

Here we send the `ShowPlayers` when the button is clicked.

And add this button to the list, change the `nav` function to:

```elm
nav : Player -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```

## Players Update

Finally, __src/Players/Update.elm__ needs to respond to the new messages.

```elm
import Navigation
```

And add two new branches to the case expression:

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.modifyUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.modifyUrl ("#players/" ++ (toString id)) )
```

`Navigation.modifyUrl` returns a command. When this command is run by Elm the location of the browser will change.

## Test it

Go to the list `http://localhost:3000/#players`. You should now see an Edit button, upon clicking it the location should change to the edit view.
