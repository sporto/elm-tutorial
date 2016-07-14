# Messages

Dans la dernière section, nous avons créé une application avec Html.App qui ne contenait que de l'Html statique. Créons maintenant une application qui répond aux interactions des utilisateurs en utilisant des messages.

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.App


-- MODEL


type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )



-- MESSAGES


type Msg
    = Expand
    | Collapse



-- VIEW


view : Model -> Html Msg
view model =
    if model then
        div []
            [ button [ onClick Collapse ] [ text "Collapse" ]
            , text "Widget"
            ]
    else
        div []
            [ button [ onClick Expand ] [ text "Expand" ] ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Ce programme est très similaire au précédent programme que nous avons réalisé, à la différence prêt qu'il contient deux messages : `Expand` (développer) et `Collapse` (plier/réduire). Vous pouvez exécuter ce programme en le copiant dans un fichier et en l'ouvrant en utilisant Elm reactor.

Jetons un œil de plus prêt aux fonctions `view` et `update`.

### View

```elm
view : Model -> Html Msg
view model =
    if model then
        div []
            [ button [ onClick Collapse ] [ text "Collapse" ]
            , text "Widget"
            ]
    else
        div []
            [ button [ onClick Expand ] [ text "Expand" ] ]
```

En fonction de l'état du modèle nous montrons la vue réduite ou la vue développée.

Notez la fonction `onClick`. Comme cette vue est du type `Html Msg`, nous pouvons déclencher des messages de ce type en utilisant `onClick`. `Collapse` et `Expand` sont tous deux du type `Msg`.

### Update

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )
```

`update` a pour rôle de répondre aux messages possibles. En fonction du message, elle retourne l'état désiré. Par exemple, lorsqu'elle reçoit le message `Expand`, le nouvel état sera `True` (développé).

Voyons ensuite comment __Html.App__ orchestre toutes ces pièces ensemble.

