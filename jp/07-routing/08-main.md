>This page covers Elm 0.18

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


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

---

### 新しいImport

`Navigation`と`Routing`のためのImportを追加しました。

### 初期化

```elm
init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )
```

`init`関数は、`Navigation`から`Location`の初期値を取るようになりました。前に作成した`parseLocation`関数を使用してこの`Location`をパースします。次に、この初期化した__route__をモデルに保存します。

### main

`main`は`Html.program`の代わりに `Navigation.program`を使います。 `Navigation.program`はHtml.programをラップしますが、ブラウザの`Location`が変更されたときにはメッセージを発行します。この場合、メッセージは`OnLocationChange`になるでしょう。
