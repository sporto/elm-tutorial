# Update

Let's do one more refactor:

```elm
module Main (..) where

import Html
import Mouse


type alias Model =
  { count : Int }


initialModel : Model
initialModel =
  { count = 0 }


view : Model -> Html.Html
view model =
  Html.text (toString model.count)


update : () -> Model -> Model
update _ model =
  { model | count = model.count + 1 }


modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel Mouse.clicks


main : Signal.Signal Html.Html
main =
  Signal.map view modelSignal
```

<https://github.com/sporto/elm-tutorial-assets/blob/master/elm_arch/Update.elm>

Here we have introduced an __update__ function.

#### update

```elm
update : () -> Model -> Model
update _ model =
  { model | count = model.count + 1 }
```

This function is equivalent to what we had before:

```elm
(\_ state -> { state | count = state.count + 1 })
```

But instead of an inline function it is now an standalone one. __update__ take the unit type (given by Mouse.clicks), the previous `Model` and returns a new `Model`.

#### foldp

In `foldp` instead of using the inline function we replace it with the __update__ function:

```elm
modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel Mouse.clicks
```

The application works the same as before but we are now using the __Model, Update, View__ pattern. This `update` function centralised changes in our application model in one place, this will become clearer later.
