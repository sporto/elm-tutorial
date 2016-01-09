# Update

Let's do one more refactor:

```elm
import Html
import Mouse

type alias Model = {
    count : Int
  }

initialModel : Model
initialModel = {
    count = 0
  }

view : Model -> Html.Html
view model =
  Html.text (toString model.count)

update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}

countSignal : Signal.Signal Model
countSignal =
  Signal.foldp update initialModel Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view countSignal

```

Here we have introduced an __update__ function.

#### Update

```elm
update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}
```

This function is equivalent to what we had before:

```elm
 (\_ state -> {state | count = state.count + 1})
```

But instead of an inline function it is now an standalone one. __update__ take the unit type (Given by Mouse.clicks), the previous `Model` and returns a new `Model`.
