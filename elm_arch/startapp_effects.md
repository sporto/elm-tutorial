# StartApp with effects

__StartApp.Simple__ may be sufficient for some application, but there is a problem with it. It doesn't allow for having side effects. Side effects might include:

- Changing the browser route
- Sending an Ajax request

These are definitely necessary things to do when building a web application. We will use the full version of StartApp from now on.

## Effects

__StartApp__ (not simple) introduces the concepts of __effects__. 

## Using StartApp complete

We need to install `elm-effects` for this: 

Stop elm reactor if running and install elm-effects

```bash
elm package install evancz/elm-effects
elm reactor
```

This is how the application looks like using StartApp complete:

```elm
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
  case action of
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
```

There are many changes here, let's go through them one by one.

```elm
import StartApp
```

We import StartApp instead of StartApp.Simple

```
import Effects exposing (Effects, Never)
import Task
```

We need to import Effects and Task, more on this later.

```elm
init : (Model, Effects Action)
init =
  (initialModel, Effects.none)
```

We now have an `init` function, this function gives us the initial input for our application.