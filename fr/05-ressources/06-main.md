# Main

Enfin, modifiez __src/Main.elm__ pour appeler `initialModel`:

```elm
module Main exposing (..)

import Html.App
import Messages exposing (Msg)
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)

init : (Model, Cmd Msg)
init =
  (initialModel , Cmd.none)

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

Nous avons ajouté `initialModel` dans les imports et dans la fonction `init`.

---

Quand vous exécutez l'application, une liste contenant un joueur devrait apparaître.

![Capture d'écran](capture.png)

L'application devrait ressembler à cela : <https://github.com/sporto/elm-tutorial-app/tree/04-resources>
