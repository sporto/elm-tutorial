# Navigation from Edit to List

Finally, let's add a back to list button to the edit view.


## Actions

Add an `ListPlayers` action to __src/Players/Actions.elm__:

```elm
    ...
    | EditPlayer PlayerId
    | ListPlayers
```

## Players Edit

In __/src/Players/Edit.elm__:

Add one more import:

```elm
import Html.Events exposing (onClick)
```

Add a new function at the end for the list button:

```elm
listBtn : Signal.Address Action -> ViewModel -> Html.Html
listBtn address model =
  button
    [ class "btn regular"
    , onClick address ListPlayers
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

Here we send the `ListPlayers` when the button is clicked.

And add this button to the list, change the `nav` function to:

```elm
nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    []
    [ listBtn address model ]
```

