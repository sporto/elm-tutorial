# StartApp with effects

__StartApp.Simple__ may be sufficient for some application, but there is a problem with it. It doesn't allow for having side effects. Side effects might include:

- Changing the browser route
- Sending an Ajax request

These are definitely necessary things to do when building a web application. We will use the full version of StartApp from now on.

## Effects

__StartApp__ (not simple) introduces the concepts of __effects__. Instead of returning just the new state in our __update__ function we will now return a tuple with the __new state__ and an __effect__ to run. It looks like: `(model, fx)`.

Our previous signature for __update__ was like:

```elm
update : Action -> Model -> Model
```
In this case __update__ returns a new state based on an __action__ and the __previous state__.

From now on the signature for __update__ will be:

```elm
update : Action -> Model -> (Model, Effects Action)
```

Here __update__ will returns the tuple `(new_state, effect_to_run)`.

__StartApp__ will take care of taking this effect and running it. This is done by sending the effect to a __port__.

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

We import `StartApp` instead of `StartApp.Simple`.


### imports

```
import Effects exposing (Effects, Never)
import Task
```

We need to import Effects and Task, more on this later.

### init

```elm
init : (Model, Effects Action)
init =
  (initialModel, Effects.none)
```

We now have an `init` function, this function gives us the initial input for our application. Before our initial input was just `initialModel`. Now our initial input is a tuple of `(initialModel, effect_to_run`).

In this case we are using `Effects.none`, meaning that we don't want any effects to run. But we could send an initial effect here, e.g. change the browser location.

### update

```elm
update : Action -> Model -> (Model, Effects Action)
update action model =
  case action ofit
    Increase ->
      ({model | count = model.count + 1}, Effects.none)
    _ ->
      (model, Effects.none)
```

`update` takes an __action__ and the __previous state__ as before but it now returns a `(new_model, effect_to_run)` tuple.

### app

```elm
app : StartApp.App Model
app = 
  StartApp.start {
    init = init,
    inputs = [],
    update = update,
    view = view
  }
```

We have also moved the call to `StartApp.run` to its own function, called `app`. __StartApp__ complete takes different inputs than __StartApp.Simple__. `view` and `update` are the same, but now we have `init` and `inputs`.

`init` is our initial application input as described above i.e. `(initialModel, initialEffect)`.

`inputs` are additional signals to listen to. StartApp will listen to these signals and merge them with any signals coming from the internal __mailbox__. What this mean is that these additional signals need to be of the same type as the main model signal.
