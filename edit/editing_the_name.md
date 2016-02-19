
# Editing the name

The last step of our tutorial application will be to edit the player's name.

## Players Action

Create a new action in __src/Players/Actions.elm__:

```elm
  ...
  | ChangeName PlayerId String
```

## View

In __src/Players/Edit.elm__ let's trigger this action.

The `Html.Events` modules has convenient functions like `onKeyUp` and `onKeyDown`. But is lacking a function to handle a change on an input field (a `change` event on an input field triggers only when the user hits enter or moves the focus out). 

We need to use the generic `on` function instead. Change `inputName` to:

```elm
inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input
    [ class "field-light"
    , value model.player.name
    , on "change" targetValue (\str -> Signal.message address (ChangeName model.player.id str))
    ]
    []
```

Here we added:

```elm
on "change" targetValue (\str -> Signal.message address (ChangeName model.player.id str))
```

`on` takes:

1. the name of the event to listen i.e. "change"

1. 1. a Json decoder that gets information out of the event object. `Html.Events.targetValue` is a Json decoder that gets the value from ``event.target.value`

1. and a function that gets this value and returns a `Signal.Message`. The anonymous function `(\str -> Signal.message address (ChangeName model.player.id str))` is just that.
