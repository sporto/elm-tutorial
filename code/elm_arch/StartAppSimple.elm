import Html
import Html.Events as Events
import StartApp.Simple

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

view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div [] [
    Html.div [] [ Html.text (toString model.count) ],
    Html.button [
      Events.onClick address Increase
    ] [ Html.text "Click" ]
  ]

update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      {model | count = model.count + 1}
    _ ->
      model

main: Signal.Signal Html.Html
main =
  StartApp.Simple.start {
    model = initialModel,
    view = view,
    update = update
  }
