# Actions

We created an `update` function.

```elm
update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}
```

As is, this `update` function can work with only one input signal i.e. `Mouse.clicks` which produces the expected `()` input.

But what we really want if for `update` to be able to handle different actions in our application. For this we will introduce the concept of __actions__ in Elm. We will use __enumerable__ types for this.

```elm
type Action =
  NoOp |
  Increase
```

Here we have an `Action` that can be either be `NoOp` (Do nothing) or `Increase` (Increase the counter).

## Adding actions

Let's refactor the application to use actions:

```elm
import Html
import Mouse

type alias Model = {
    count : Int
  }

type Action =
  NoOp |
  Increase

initialModel : Model
initialModel = {
    count = 0
  }

view : Model -> Html.Html
view model =
  Html.text (toString model.count)

update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      {model | count = model.count + 1}
    _ ->
      model

actionSignal : Signal.Signal Action
actionSignal =
  Signal.map (\_ -> Increase) Mouse.clicks

modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal

main: Signal.Signal Html.Html
main =
  Signal.map view modelSignal
```

#### actions

We added `type Action ...` as described before.

#### update

```elm
update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      {model | count = model.count + 1}
    _ ->
      model
```

The `update` function now takes an `Action` as first argument, instead of `()`.

We added a `case` to deal with different actions. This case checks for the type of action and acts accordingly.