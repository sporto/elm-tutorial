# Actions: Payload

You can send a payload with your actions:

```elm
module Main (..) where

import Html
import Mouse


type alias Model =
  { count : Int }


type Action
  = NoOp
  | MouseClick Int


initialModel : Model
initialModel =
  { count = 0 }


view : Model -> Html.Html
view model =
  Html.text (toString model.count)


update : Action -> Model -> Model
update action model =
  case action of
    MouseClick amount ->
      { model | count = model.count + amount }

    NoOp ->
      model


mouseClickSignal : Signal.Signal Action
mouseClickSignal =
  Signal.map (\_ -> MouseClick 2) Mouse.clicks


modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel mouseClickSignal


main : Signal.Signal Html.Html
main =
  Signal.map view modelSignal
```

<https://github.com/sporto/elm-tutorial-assets/blob/master/code/elm_arch/ActionsWithPayload.elm>

Note the new __actions__ declaration:

```
MouseClick Int
```

This is saying that the `MouseClick` action should be accompanied with an integer.

Then in mouseClickSignal:

```elm
mouseClickSignal =
  Signal.map (\_ -> MouseClick 2) Mouse.clicks
```

We map mouse clicks to the `MouseClick` action with `2` as its payload.

Finally, `update` uses __pattern matching__ in the case expression to extract the payload:

```elm
case action of
  MouseClick amount ->
    { model | count = model.count + amount }
