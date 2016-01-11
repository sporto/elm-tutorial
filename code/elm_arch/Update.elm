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

update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}

countSignal : Signal.Signal Model
countSignal =
  Signal.foldp update initialModel Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view countSignal
