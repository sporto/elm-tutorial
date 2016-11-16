> This page covers Elm 0.17

# Souscriptions

En Elm, les __souscriptions__ (*subscriptions*) sont ce qui permet à votre application d'écouter les entrées externes. Par exemple :

- les [événements clavier](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- les [mouvements de la souris](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- les changements d'adresse du navigateur
- les [événements Websocket](http://package.elm-lang.org/packages/elm-lang/websocket/latest/WebSocket)

Pour illustrer ce concept, créons une application qui réagit à la fois aux événements clavier et souris.

D'abord, installez les bibliothèques requises

```bash
elm package install elm-lang/mouse
elm package install elm-lang/keyboard
```

Puis créez ce programme

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Mouse
import Keyboard


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.presses KeyMsg
        ]



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

Exécutez ce programme avec Elm reactor. À chaque clic de la souris, le compteur augmentera de 1, et à chaque touche du clavier pressée, le compteur augmentera de 2.

---

Étudions les parties concernant les souscriptions dans ce programme.

### Messages

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

Il y a deux messages possibles : `MouseMsg` et `KeyMsg`, qui seront déclenchés lorsque qu'on cliquera sur la souris ou qu'on appuiera sur une touche du clavier.

### Mise à jour

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )
```

Notre fonction de mise à jour répond à chaque message différemment, afin d'incrémenter le compteur de 1 lorsque la souris est cliquée, et de 2 lorsqu'on appuie sur une touche.

### Souscriptions

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.presses KeyMsg ➋
        ]
```

Ici, on déclare les choses que l'on veut écouter. On souhaite réagir aux `Mouse.clicks` ➊ et aux `Keyboard.presses` ➋. Ces deux fonctions prennent un constructeur de message et retournent une souscription.

On utilise `Sub.batch` ➌ pour pouvoir écouter les deux en même temps. `Batch` prend une liste de souscriptions et retourne une seule souscription qui les contient toutes.
