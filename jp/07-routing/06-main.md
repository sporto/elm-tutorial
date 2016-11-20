>このページでは、Elm 0.17

# メイン

最後に、メインモジュールのすべてを配線する必要があります。

__src/Main.elm__を次のように変更します。

```elm
module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
```

---

### 新しいImport

`Navigation`と`Routing`のためのImportを追加しました。

### 初期化

```elm
init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

init関数は `Routing`に追加した`parser`から初期的な出力を受け取ります。パーサーの出力は `Result`です。 __Navigation__モジュールは初期ブラウザ閲覧ロケーションを解析し、その結果を `init`に渡します。この__route__初期値をモデルに格納します。

### urlUpdate

`urlUpdate`は、ブラウザの場所が変更されるたびに__Navigation__パッケージによって呼び出されます。 `init`のように、ここではパーサの結果を得ます。ここで行うのは、新しい__route__をアプリケーションモデルに格納することだけです。

### main

`main`は`Html.App.program`の代わりに `Navigation.program`を使います。 `Navigation.program`はHtml.Appをラップしますが、ブラウザの場所が変更されたときには`urlUpdate`コールバックを追加します。
