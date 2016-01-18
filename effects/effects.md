# Effects

Effects are a higher level abstraction than tasks for anything that produces side effects. An __Effects__ type is always a collection of effects to run (as opposed to a task which is singular). Our components will return __effects__ that need to be ran by the Elm runtime. 

Most of the time we will be creating __tasks__ and converting them to effects.

## Sample application

Following is a sample application using Effects. Don't worry too much if this application doesn't make full sense, later on we will use __StartApp__ again, encapsulates a lot of complexity here.

```elm
import Html
import Html.Events as Events
import Http
import Task
import Debug
import Effects

type Action =
  NoOp |
  Refresh |
  OnRefresh (Result Http.Error String)

type alias Model = String

view : Signal.Address Action -> Model -> Html.Html
view address message =  
  Html.div [] [
    Html.button [
      Events.onClick address Refresh
    ]
    [
      Html.text "Refresh"
    ],
    Html.text message
  ]

actionsMailbox : Signal.Mailbox (List Action)
actionsMailbox =
  Signal.mailbox []

oneActionAddress : Signal.Address Action
oneActionAddress =
  Signal.forwardTo actionsMailbox.address (\action -> [action])

httpTask : Task.Task Http.Error String
httpTask =
  Http.getString "http://localhost:3000/"

refreshFx : Effects.Effects Action
refreshFx =
  httpTask
    |> Task.toResult
    |> Task.map OnRefresh
    |> Effects.task

-- OK
update : Action -> Model -> (Model, Effects.Effects Action)
update action model =
  case action of
    Refresh ->
      (model, refreshFx)
    OnRefresh result ->
      let
        message =
          Result.withDefault "" result
      in
        (message, Effects.none)
    _ ->
      (model, Effects.none)

modelAndFxSignal : Signal.Signal (Model, Effects.Effects Action)
modelAndFxSignal =
  let
    modelAndFx action (previousModel, _) =
      update action previousModel
    modelAndManyFxs actions (previousModel, _) =
      List.foldl modelAndFx (previousModel, Effects.none) actions
    initial =
      ("-", Effects.none)
  in
    Signal.foldp modelAndManyFxs initial actionsMailbox.signal

modelSignal : Signal.Signal Model
modelSignal =
  Signal.map fst modelAndFxSignal

fxSignal : Signal.Signal (Effects.Effects Action)
fxSignal =
  Signal.map snd modelAndFxSignal

taskSignal : Signal (Task.Task Effects.Never ())
taskSignal =
  Signal.map (Effects.toTask actionsMailbox.address) fxSignal

main: Signal.Signal Html.Html
main =
  Signal.map (view oneActionAddress) modelSignal

port runner : Signal (Task.Task Effects.Never ())
port runner =
  taskSignal
```

In order to run this app, you will also need to have the __node json-server__, refer to the __Task__ chapter for the instructions on setting this up.

This application display a "Refresh" button. When this button is clicked the application sends an ajax request to the node server, then the result is displayed when it comes back.

As usual, let's go through the parts of this app:

#### actions

```elm
type Action =
  NoOp |
  Refresh |
  OnRefresh (Result Http.Error String)
```

The `Refresh` action will trigger the ajax request.
When the request is finished we will trigger a `OnRefresh` action. This `OnRefresh` action will have a `Result` as payload. This result may have an http error or a string. This string is the response body from the server when the result is successful.

#### view

The `view` display the "Refresh" button and a message (this message will be the response from the server). When the "Refresh" button is clicked we send a `Refresh` action to the provided address.

#### actionsMailbox

A mailbox where to send action messages. Note however that this mailbox expects a list of actions, not just one action: `Signal.Mailbox (List Action)`.

This is because the way __effects__ work. `Effects` is a collection of effects, not just one. When effects are ran and translated back to actions they will produce a list of them.


