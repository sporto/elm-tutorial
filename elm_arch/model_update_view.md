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

countSignal : Signal.Signal Model
countSignal =
  Signal.foldp (\_ state -> {state | count = state.count + 1}) initialModel Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view countSignal

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

### State signal

```elm
countSignal : Signal.Signal Model
countSignal =
  Signal.foldp (\_ state -> {state | count = state.count + 1}) initialModel Mouse.clicks
```

Instead of having `countSignal` be a signal of `Signal