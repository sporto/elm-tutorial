> This page covers Tutorial v2. Elm 0.18.

# Navigation

Next let's add buttons to navigate between views.


## Routing

In __src/Routing.elm__ add two new functions:

```elm
playersPath : String
playersPath =
    "#players"


playerPath : PlayerId -> String
playerPath id =
    "#players/" ++ id
```

## Players List

The players' list needs to show a button for each player to trigger the `ShowPlayer` message.

In __src/Players/List.elm__. First import `href` and `Routing` :

```elm
import Html.Attributes exposing (class, href)
...
import Routing exposing (playerPath)
```

Add a new function for this button at the end:

```elm
editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

This button is a common `a` tag, which will change the browser url directly. As we are using hash routing we can just change the location hash and routing will work.

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

Add the imports:

```elm
import Html.Attributes exposing (class, value, href)
import Routing exposing (playersPath)
```

Add a new function at the end for the list button:

```elm
listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

And add this button to the list, change the `nav` function to:

```elm
nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```
