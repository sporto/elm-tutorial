import Html
import Html.Events as Events
import StartApp
import Effects exposing (Effects, Never)
import Task

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

init : (Model, Effects Action)
init =
  (initialModel, Effects.none)

view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div [] [
    Html.div [] [ Html.text (toString model.count) ],
    Html.button [
      Events.onClick address Increase
    ] [ Html.text "Click" ]
  ]

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action ofit
    Increase ->
      ({model | count = model.count + 1}, Effects.none)
    _ ->
      (model, Effects.none)

app : StartApp.App Model
app = 
  StartApp.start {
    init = init,
    inputs = [],
    update = update,
    view = view
  }

main: Signal.Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
