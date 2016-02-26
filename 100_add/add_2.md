# Create button in Players List

Finally, let's add the add player button to the players' list.

In __src/Players/List.elm__ add:

```elm
...

addBtn : Signal.Address Action -> ViewModel -> Html.Html
addBtn address model =
  button
    [ class "btn", onClick address CreatePlayer ]
    [ i [ class "fa fa-user-plus mr1" ] []
    , text "Add player"
    ]
 ```

This renders a button that when clicked send the `CreatePlayer` action. Which trigger the effect to create the player in `Players.Update`.

And add the button to the navigation in this module:

```elm
...
nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Players" ]
    , div [ class "right p1" ] [ addBtn address model ]
    ]
```