# Actions: Multiple

To understand the beauty of using ADTs for actions, imagine what will happen if you have several actions that can happen in your application e.g. mouse clicks, key up, key downs, etc. By converting everything to __actions__ our application can handle all these cases.

Here is an application that responds to both mouse clicks and key presses:

```elm
module Main (..) where

import Html exposing (Html)
import Mouse
import Keyboard


type alias Model =
  { count : Int
  }


type Action
  = NoOp
  | MouseClick
  | KeyPress


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
    MouseClick ->
      { model | count = model.count + 1 }

    KeyPress ->
      { model | count = model.count - 1 }

    _ ->
      model


mouseClickSignal : Signal.Signal Action
mouseClickSignal =
  Signal.map (\_ -> MouseClick) Mouse.clicks


keyPressSignal : Signal.Signal Action
keyPressSignal =
  Signal.map (\_ -> KeyPress) Keyboard.presses


actionSignal : Signal.Signal Action
actionSignal =
  Signal.merge mouseClickSignal keyPressSignal


modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal


main : Signal.Signal Html
main =
  Signal.map view modelSignal
```

<https://github.com/sporto/elm-tutorial-assets/blob/master/code/030_elm_arch/ActionsMultiple.elm>

Every mouse click increases the count, every key press decreases the count. Note how we __merge__ the signals (mouseClickSignal and keyPressSignal) into one, as they both are of type `Signal.Signal Action` our foldp can handle them.

```elm
actionSignal : Signal.Signal Action
actionSignal =
  Signal.merge mouseClickSignal keyPressSignal
```
