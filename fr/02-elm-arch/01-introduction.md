# Introduction

Lorsque nous construisons des applications frontend avec Elm, nous utilisons un modèle nommé l'__architecture Elm__. Ce modèle fourni un moyen de créer des composants autonomes qui peuvent être réutilisés, combinés et composés à l'infini.

Elm fourni le module `Html.App` pour cela. Le plus simple pour comprendre est de créer une petite application.

Installez elm-html :

```elm
elm package install elm-lang/html
```

Créez un fichier nommé __App.elm__ :

```elm
module App exposing (..)

import Html exposing (Html, div, text)
import Html.App


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



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

Vous pouvez exécutez ce programme en lançant :

```bash
elm reactor
```

Et en ouvrant <http://localhost:8000/App.elm> dans votre navigateur.

Ça fait beaucoup de code pour afficher "Hello", mais ça va nous aider à comprendre la structure des applications Elm, même celles qui sont très compliquées.

