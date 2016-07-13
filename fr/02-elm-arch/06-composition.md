# Composition

Un des grands avantages d'utiliser l'architecture Elm est la façon dont la relation entre les composants est gérée. Voyons cela avec un exemple :

- Nous allons avoir un composant parent `App`
- Et un composant enfant `Widget`

## Composant enfant

Commençons par le composant enfant. Voici le code du fichier __Widget.elm__ :

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

Ce composant est quasiment identique à l'application que nous avons réalisée dans la section précédente, à l'exception des souscriptions et du _main_. Ce composant :

- Définit ses propres messages (Msg)
- Définit son propre modèle
- Fourni une fonction `update` qui répond à ses propres messages, comme par exemple `Increase`.

Notez que le composant ne connait que les choses qui a déclaré lui-même. `view` et `update` n'utilisent que des types qui ont été déclarées dans le compsant (`Msg` et `Model`).

Dans la section suivante, nous allons créer le composant parent.
