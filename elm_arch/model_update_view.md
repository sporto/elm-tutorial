# Model, update, view

Now that we can keep state using `foldp`, we can refactor our application to follow the __Elm architecture__ pattern.

Taking the application we had before we will refactor it to this:

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

countSignal : Signal Model
countSignal =
  Signal.foldp (\_ state -> {state | count = state.count + 1}) initialModel Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view countSignal

```

Let's look at what's new:

```elm
type alias Model = Int
```

This line declares a `type alias` called Model, this is equivalent to the `Int` type. We can use the `Int` type 