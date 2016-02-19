# Changing level

# Actions and effects

We will add a couple of new actions for changing a player's level. In __src/Players/Actions.elm__ add:

```elm
  ...
  | ChangeLevel PlayerId Int
  | SaveDone (Result Http.Error Player)
```

- `ChangeLevel` will trigger when the user wants to change the level. The second parameter is an integer that indicates how much to change the level e.g. -1 to decrease or 1 to increase.
- Then we will send a request to update the player to the API. `SaveDone` will be triggered after we get the response from the API.

## Players Edit

We created a `ChangeLevel` action. Let's trigger this action from the player's edit view.

In __src/Players/Edit.elm__ change `btnLevelIncrease` and `btnLevelIncrease`:

```elm
...
btnLevelIncrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelDecrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-minus-circle"
        , onClick address (ChangeLevel model.player.id -1)
        ]
        []
    ]


btnLevelIncrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelIncrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-plus-circle"
        , onClick address (ChangeLevel model.player.id 1)
        ]
        []
    ]
```

In these two buttons we added `onClick address (ChangeLevel model.player.id howMuch)`. Where `howMuch` is `-1` to decrease level and `1` to increase.
