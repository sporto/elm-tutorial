# Actions

We created an `update` function.

```elm
update : () -> Model -> Model
update _ model =
  { model | count = model.count + 1 }
```

As is, this `update` function can work with only one input signal i.e. `Mouse.clicks` which produces the expected `()` input.

But what we really want is for `update` to be able to handle different actions in our application. For this we will introduce the concept of __actions__ in Elm. We will use __Algebraic data types (ADT)__ for this.

```elm
type Action
  = NoOp
  | Increase
```

Here we have an `Action` that can be either be `NoOp` (Do nothing) or `Increase` (Increase the counter).

## Adding actions

Let's refactor the application to use actions:

```elm
module Main (..) where

import Html exposing (Html)
import Mouse


type alias Model =
  { count : Int
  }


type Action
  = NoOp
  | Increase


initialModel : Model
initialModel =
  { count = 0
  }


view : Model -> Html
view model =
  Html.text (toString model.count)


update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      { model | count = model.count + 1 }

    NoOp ->
      model


actionSignal : Signal.Signal Action
actionSignal =
  Signal.map (\_ -> Increase) Mouse.clicks


modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal


main : Signal.Signal Html
main =
  Signal.map view modelSignal
```

<https://github.com/sporto/elm-tutorial-assets/blob/master/code/elm_arch/Actions.elm>

#### actions

We added `type Action ...` as described before.

#### update

```elm
update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      { model | count = model.count + 1 }

    NoOp ->
      model
```

The `update` function now takes an `Action` as first argument, instead of `()`.

We added a `case` to deal with different actions. This case checks for the type of action and acts accordingly.

The Increase case returns a new model with it's count property incremented, same as before.

The NoOp case just returns the same model.

### actionSignal

```elm
actionSignal : Signal.Signal Action
actionSignal =
  Signal.map (\_ -> Increase) Mouse.clicks
```

Here we introduce a new signal as an intermediate step before the `modelSignal`. This signal listens for mouse clicks and maps them to an action, in this case `Increase`.

### modelSignal

```elm
modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal
```

The model signal now takes the `actionSignal` as input and calls update with the action.


