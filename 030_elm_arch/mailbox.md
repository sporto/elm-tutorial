# Mailbox

So far we have a __model__, an __update__ function and __actions__. The last building block is adding a __mailbox__ to handle user interaction with the UI.

Let's change the previous application so the user can click on html buttons instead of clicking the mouse anywhere.

```elm
module Main (..) where

import Html exposing (Html)
import Html.Events as Events


type alias Model =
  { count : Int }


type Action
  = NoOp
  | Increase


initialModel : Model
initialModel =
  { count = 0
  }


view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.div [] [ Html.text (toString model.count) ]
    , Html.button
        [ Events.onClick address Increase ]
        [ Html.text "Click" ]
    ]


update : Action -> Model -> Model
update action model =
  { model | count = model.count + 1 }


mb : Signal.Mailbox Action
mb =
  Signal.mailbox NoOp


modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel mb.signal


main : Signal.Signal Html
main =
  Signal.map (view mb.address) modelSignal
```

<https://github.com/sporto/elm-tutorial-assets/blob/master/code/elm_arch/Mailbox.elm>

The big difference is the introduction of the __mailbox__. The mailbox provides an address where to send messages and a signal to listen to. See the chapter on Signals/Mailbox for more information.
