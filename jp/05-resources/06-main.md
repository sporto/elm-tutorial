>This page covers Elm 0.18

# メイン

最後に`initialModel`を呼び出すように__src/Main.elm__を修正します：

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

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

ここでは、インポートに `initialModel`を追加し、`init`を追加しました。

---

アプリケーションを実行すると、1人のユーザーのリストが表示されます。

![Screenshot](screenshot.png)

アプリケーションは<https://github.com/sporto/elm-tutorial-app/tree/04-resources>のようになります。
