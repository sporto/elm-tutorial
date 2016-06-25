# Composing

One of the big benefits of using the Elm architecture is the way it handles composition of components. To understand this, let's build an example:

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
        , button [ onClick Increase ] [ Html.text "Click" ]
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
