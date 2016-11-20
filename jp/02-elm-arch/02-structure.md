>このページでは、Elm 0.18

# Html.Appの構造

### Import

```elm
import Html exposing (Html, div, text, program)
```

- `Html`モジュールの`Html`型と、 `div`、`text`、 `program`などいくつかの関数を使用します。

### モデル

```elm
type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
```

まず、この種のアプリケーションのモデルを型エイリアスとして定義します。ここでは単に `String`です。
次に、 `init`関数を定義します。この関数は、アプリケーションの初期入力値を提供します。

__Html.program__は `(model, command)`というタプルを期待しています。このタプルの最初の要素は、初期状態です(例えば"Hello")。2番目の要素は、実行する最初のコマンドです。これについては後で詳しく説明します。

elmアーキテクチャを使用する場合、すべてのコンポーネントのモデルを一つの状態ツリーとして構築します。これについては後で詳しく説明します。

### メッセージ

```elm
type Msg
    = NoOp
```

メッセージは、コンポーネントが応答するアプリケーションで発生するものです。この場合、アプリケーションは何もしないので、`NoOp`というメッセージしかありません。

メッセージの他の例としては、ウィジェットの表示と非表示を切り替えるための「Expand」または「Collapse」があります。メッセージにはユニオン型を使用します：

```elm
type Msg
    = Expand
    | Collapse
```

### ビュー

```elm
view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

`view`関数は、アプリケーションのモデルを使ってHtml要素をレンダリングします。型シグネチャは `Html Msg`であることに注意してください。これは、このHtml要素がMsgというタグが付けられたメッセージを生成することを意味します。今後、インタラクションを導入するときに必要になります。

### 更新

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

次に、 `update`関数を定義します。この関数は、メッセージが受信されるたびにHtml.Appによって呼び出されます。`update`関数は、モデルを更新するメッセージに応答し、必要に応じてコマンドを返します。

この例では、 `NoOp`にのみ応答し、変更されていないモデルと、実行するコマンドがないことを意味する`Cmd.none`を返します。

### サブスクリプション(購読)

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
```

サブスクリプションを使用して、アプリケーションへの外部入力を待ち受けます。サブスクリプションのいくつかの例は次のとおりです。

- マウスの移動
- キーボードイベント
- ブラウザの閲覧ロケーションの変更

この場合には、外部入力には関心がないので、Sub.noneを使用しています。

### メイン

```elm
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

最後に、 `Html.program`はすべてを結びつけ、ページ中にレンダリングできるhtml要素を返します。 `program`関数は引数に`init`、 `view`、`update`と `subscriptions`を取ります。
