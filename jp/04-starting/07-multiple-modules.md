>This page covers Elm 0.18

# 複数のモジュール

アプリケーションはすぐに成長してしまいます。したがって、ファイルを1つのファイルに保存してしまうと、たちまち維持するのが難しくなるでしょう。

### 循環的な依存関係

直面するかもしれない別の問題は、循環依存です。たとえば、次のような場合があります。

- `Player`型を定義する`Main`モジュール
- `Main`で宣言された`Player`型をインポートする `View`モジュール
- ビューをレンダリングする `View`をインポートする`Main`

このとき、循環的な依存が発生しています。

```elm
Main --> View
View --> Main
```

#### 回避方法は？

この場合、 `Player`型を`Main`から `Main`と`View`の両方で読み込むことができるようにする必要があります。

Elmで循環的な依存関係を処理するには、アプリケーションをより小さなモジュールに分割するのが最も簡単です。この特定の例では、 `Main`と`View`の両方でインポートできる別のモジュールを作成できます。私たちは3つのモジュールを持つことになります：

- メイン
- ビュー
- モデル(`Player`型を含む)

これで依存関係は次のようになります。

```elm
Main --> Models
View --> Models
```

これで循環依存はなくなりました。

__messages__、__models__、__commands__、__utilities__などのモジュール用に別々のモジュールを作成してみてください。モジュールは通常、多くのコンポーネントからインポートされます。

---

小さなモジュールでアプリケーションを分割しましょう：

__src/Messages.elm__

```elm
module Messages exposing (..)


type Msg
    = NoOp
```

__src/Models.elm__

```elm
module Models exposing (..)


type alias Model =
    String
```

__src/Update.elm__

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

__src / View.elm__

```elm
module View exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg)
import Models exposing (Model)
import View exposing (view)

view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src / Main.elm__

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


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

コードはこちらにあります<https://github.com/sporto/elm-tutorial-app/tree/018-03-multiple-modules>

---

たくさんのモジュールを作成しましたが、簡単なアプリケーションには過剰でしょう。しかし、より大きなアプリケーションでは、分割すると作業がより簡単になります。
