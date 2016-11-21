> This page covers Elm 0.18

# Main

Finally modify __src/Main.elm__ to call `initialModel`:

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Here we added `initialModel` in the import and `init`.

---

When you run the application you should see a list with one user.

![Screenshot](screenshot.png)

The application should look like <https://github.com/sporto/elm-tutorial-app/tree/04-resources>

