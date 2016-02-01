# StartApp with effects

As discussed __StartApp.Simple__ doesn't allow for having side effects. This side effects might be:

- Changing the browser route
- Sending an Ajax request

These are definitely necessary things to do when building a web application. We will use the full version of StartApp from now on.

## Using StartApp

__StartApp__ (not simple) introduces the concepts of __effects__. Instead of returning just the new state in our __update__ function we will now return a tuple with the __new state__ and __effects__ to run. It looks like: `(model, effects)`.

Let's convert the application we looked at in the last chapter to __StartApp__.

```elm
module Main (..) where

import Effects exposing (Effects, Never)
import Html
import Html.Events as Events
import Http
import StartApp
import Task


type Action
  = NoOp
  | Refresh
  | OnRefresh (Result Http.Error String)


type alias Model =
  String


view : Signal.Address Action -> Model -> Html.Html
view address message =
  Html.div
    []
    [ Html.button
        [ Events.onClick address Refresh 
        ]
        [ Html.text "Refresh" 
        ]
    , Html.text message
    ]


httpTask : Task.Task Http.Error String
httpTask =
  Http.getString "http://localhost:3000/"


refreshFx : Effects.Effects Action
refreshFx =
  httpTask
    |> Task.toResult
    |> Task.map OnRefresh
    |> Effects.task


init : ( Model, Effects Action )
init =
  ( "", Effects.none )


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  case Debug.log "action" action of
    Refresh ->
      ( model, refreshFx )

    OnRefresh result ->
      let
        message =
          Result.withDefault "" result
      in
        ( message, Effects.none )

    _ ->
      ( model, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
```

### actions

As previously, `Refresh` is send to trigger a refresh, `OnRefresh` is send when the Ajax request has completed.

### view

Same view as we had in the __Effects__ chapter. This view renders a "Refresh" button and the provided message. When the "Refresh" button is clicked we send the `Refresh` action to an address provided by __StartApp__.

### httpTask and refreshFx

These two create an http task and wrap it into an `Effects`. When the effects are ran we will send the `OnRefresh` action. For more details on this code see the previous chapter.

### init

We now have an `init` function, this function gives us the initial input for our application, which is a tuple of `(initialModel, effect_to_run`).

In this case we are using `Effects.none`, meaning that we don't want any effects to run. But we could send an initial effect here, e.g. an initial request when the application loads.

### update

Same `update` as in the previous chapter, it responds to `Refresh` by returning the current model and the `refreshFx`. And it responds to `OnRefresh` by changing the model.

### app

```elm
app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }
```

We have a new function `app`. This function bootstraps StartApp.

`init` is our initial application input as described above i.e. `(initialModel, initialEffect)`.

#### inputs

`inputs` are additional signals to listen to. StartApp will listen to these signals and merge them with any signals coming from the internal __mailbox__. What this mean is that these additional signals need to be of the same type as the main model signal.

This function returns an __StartApp__ record like:

```elm
{ html : Signal.Signal Html.Html
, model : Signal.Signal model
, tasks : Signal.Signal (Task.Task Effects.Never ())
}
```

- `html` is a signal of html elements.
- `model` is a signal with the application model.
- `tasks` is a signal with tasks to run.

### main

```elm
main : Signal.Signal Html.Html
main =
  app.html
```

`main` now uses `app.html` which is the signal of html provided by StartApp.

### port

```elm
port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
```

Finally we need to create a `port`. `runner` is the name of the port. This port is necessary so any task send via effects are actually run. If this port is omitted then any effects that we return in __update__ won't be run.

## Conclusion

Using __StartApp__ is much simpler than doing our own thing (as we did in the previous chapter). A bunch of complex code is encapsulated within StartApp.

In the next section we will start building a full web application.
