> This page covers Elm 0.18

# Composing

The following pages explain a composition pattern in Elm where you split your messages, models and views in logical groups. 

It looks like:

```
Root
  - Model
  - Messages
  - Update
  - Views

  Group
    - Model
    - Messages
    - Update
    - Views
```

`Group` in this case could be a resource (e.g. users), a UI element (e.g. a dropdown), a sub application.

## Use with care

In general it is recommended that you keep your *models* and *messages* shallow. This allows to have less boilerplate when working with Elm. Don't think in term of "components" in Elm. It is better to think about views on one side and messages and models on another, not necessarily coupled.

## Composition with the Elm Architecture

Sometimes we still want to compose like this. To understand how this works, let's build an example:

- We will have a parent component `App`
- And a child component `Widget`

## Child component

Let's begin with the child component. This is the code for __Widget.elm__.

```elm
module Widget exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }



-- MESSAGES


type Msg
    = Increase



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.count) ]
        , button [ onClick Increase ] [ text "Click" ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | count = model.count + 1 }, Cmd.none )
```

This component is nearly identical to the application that we made in the last section, except for subscriptions and main. This component:

- Defines its own messages (Msg)
- Defines its own model
- Provides an `update` function that responds to its own messages, e.g. `Increase`.

Note how the component only knows about things declared here. Both `view` and `update` only use types declared within the component (`Msg` and `Model`).

In the next section we will create the parent component.
