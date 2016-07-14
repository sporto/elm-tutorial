# Messages et données attachées

Il est possible d'attacher des données à vos messages :

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.App


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = Increment Int



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Increment 2) ] [ text "+" ]
        , text (toString model)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Notez la manière dont le message `Increment` requiert un entier :

```elm
type Msg
    = Increment Int
```

Ensuite dans la vue, nous déclenchons ce message en lui attachant des données (ici un entier) :

```elm
onClick (Increment 2)
```

Et finalement, dans la fonction `update`, nous utilisons du __pattern matching__ pour extraire les données :

```elm
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )
```
