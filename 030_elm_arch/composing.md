# Composing

One of the big benefits from using the Elm architecture is the way it handles composition of components. To understand this let's build an example:

- We will have a parent component `App`
- And a child component `Widget`

## Children component

Let's begin with the children component. This is the code for __Widget.elm__:

```elm
module Widget (..) where

import Html exposing (Html)
import Html.Events as Events


-- MODEL


type alias Model =
  { count : Int
  }


type Action
  = Increase


initialModel : Model
initialModel =
  { count = 0
  }



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.div [] [ Html.text (toString model.count) ]
    , Html.button
        [ Events.onClick address Increase
        ]
        [ Html.text "Click" ]
    ]



-- UPDATE


update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      { model | count = model.count + 1 }
```

This component should be straighforward to understand as it is nearly identical to the application that we made in the last section. 

This component has:

- a `Model`
- actions i.e. `Increase`
- a `view` that displays the counter and a button for increasing it
- an `update` function that responds to the `Increase` action and changes the model

Note how the component only knows about things declared here. Both `view` and `update` only use types declared within the component (`Action` and `Model`).

## The parent component

This is the code for the parent component. __Main.elm__:

```elm
module Main (..) where

import Html exposing (Html)
import StartApp.Simple
import Widget as Widget


-- MODEL


type alias AppModel =
  { widgetModel : Widget.Model
  }


type Action
  = WidgetAction Widget.Action


initialModel : AppModel
initialModel =
  { widgetModel = Widget.initialModel
  }



-- VIEW


view : Signal.Address Action -> AppModel -> Html
view address model =
  Html.div
    []
    [ Widget.view (Signal.forwardTo address WidgetAction) model.widgetModel
    ]



-- UPDATE


update : Action -> AppModel -> AppModel
update action model =
  case action of
    WidgetAction subAction ->
      let
        updatedWidgetModel =
          Widget.update subAction model.widgetModel
      in
        { model | widgetModel = updatedWidgetModel }



-- START APP


main : Signal.Signal Html
main =
  StartApp.Simple.start
    { model = initialModel
    , view = view
    , update = update
    }
```