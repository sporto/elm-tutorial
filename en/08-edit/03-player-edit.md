> This page covers Tutorial v2. Elm 0.18.

## Player edit view

We created a `ChangeLevel` message. Let's trigger this message from the player's edit view.

In __src/Players/Edit.elm__, first add `onClick`:

```elm
import Html.Events exposing (onClick)
```

And change `btnLevelDecrease` and `btnLevelIncrease`:

```elm
...
btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    let
        message =
            Msgs.ChangeLevel player -1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    let
        message =
            Msgs.ChangeLevel player 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]
```

In these two buttons we added `onClick message`. This `message` is `Msgs.ChangeLevel player howMuch`. Where `howMuch` is `-1` to decrease level and `1` to increase it.
