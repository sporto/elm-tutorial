import Html
import Mouse
import Keyboard

type alias Model = {
    count : Int
  }

type Action =
  NoOp |
  MouseClick Int

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
    MouseClick amount ->
      {model | count = model.count + amount}
    _ ->
      model

mouseClickSignal : Signal.Signal Action
mouseClickSignal =
  Signal.map (\_ -> MouseClick 2) Mouse.clicks

modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel mouseClickSignal

main: Signal.Signal Html.Html
main =
  Signal.map view modelSignal
