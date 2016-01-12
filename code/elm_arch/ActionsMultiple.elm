import Html
import Mouse
import Keyboard

type alias Model = {
    count : Int
  }

type Action =
  NoOp |
  MouseClick |
  KeyPress

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
    MouseClick ->
      {model | count = model.count + 1}
    KeyPress ->
      {model | count = model.count - 1}
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

main: Signal.Signal Html.Html
main =
  Signal.map view modelSignal
