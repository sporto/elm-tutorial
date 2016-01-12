# Model

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

modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp (\_ state -> {state | count = state.count + 1}) initialModel Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view modelSignal

```

Let's look at what's new.

### Model

```elm
type alias Model = {
    count : Int
  }
```

Here we introduce a `type alias` called `Model`. This type alias defines the structure of a record in Elm. A `Model` record in our application needs to have a `count` attribute, which is an integer.

### Initial model

```elm
initialModel : Model
initialModel = {
    count = 0
  }
```

This function returns the initial model of our application. In this case it returns `Model` record with `count` set to 0.

### view

```elm
view : Model -> Html.Html
view model =
  Html.text (toString model.count)
```

Our view now takes a `Model` record and displays the count by accessing `model.count`.

### Model signal

```elm
modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp (\_ state -> {state | count = state.count + 1}) initialModel Mouse.clicks
```

Instead of having `modelSignal` be a signal of `Signal.Signal Int`, now it is a `Signal.Signal Model`. So it is a signal that emits `Model`.

The __accumulation__ function in `foldp` takes the previous model and returns a new one. It updates the `count` attribute in the previous model using:

```elm
{state | count = state.count + 1}
```

In Elm all data structure are immutable. So this syntax above is how you return a new immutable record with one property updated. Read mode ABOUT THIS HERE.

