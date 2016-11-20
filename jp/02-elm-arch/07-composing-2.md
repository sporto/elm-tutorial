>このページでは、Elm 0.18

# 合成

## 親コンポーネント

これは親コンポーネントのコードです。

```elm
module Main exposing (..)

import Html exposing (Html, program)
import Widget

-- モデル


type alias AppModel =
    { widgetModel : Widget.Model
    }


initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel
    }


init : ( AppModel, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- メッセージ


type Msg
    = WidgetMsg Widget.Msg



-- VIEW


view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.App.map WidgetMsg (Widget.view model.widgetModel)
        ]


-- 更新


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case message of
        WidgetMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Widget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )


-- サブスクリプション(購読)


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- APP


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

---

このコードの重要なセクションを見てみましょう。

### モデル

```elm
type alias AppModel =
    { widgetModel : Widget.Model ➊
    }
```

親コンポーネントには独自のモデルがあります。このモデルの属性の1つに`Widget.Model`➊が含まれています。この親コンポーネントは `Widget.Model`の中身を知る必要はないことに注意してください。

```elm
initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel ➋
    }
```

最初のアプリケーションモデルを作成するときは、単にここから `Widget.initialModel`➋を呼び出します。

子コンポーネントが複数ある場合は、それぞれの子コンポーネントを同じように実行します。たとえば、次のようになります。

```elm
initialModel : AppModel
initialModel =
    { navModel = Nav.initialModel,
    , sidebarModel = Sidebar.initialModel,
    , widgetModel = Widget.initialModel
    }
```

あるいは、同じタイプの複数の子コンポーネントを持つこともできます。

```elm
initialModel : AppModel
initialModel =
    { widgetModels = [Widget.initialModel]
    }
```

### メッセージ

```elm
type Msg
    = WidgetMsg Widget.Msg
```

メッセージがそのコンポーネントに属していることを示すために `Widget.Msg`をラップする__ユニオン型__を使用します。これにより、アプリケーションが関連するコンポーネントにメッセージをルーティングできるようになります(これは、update関数を見ればより明確になります)。

複数の子コンポーネントを持つアプリケーションでは、次のようなものがあります。

```elm
type Msg
    = NavMsg Nav.Msg
    | SidebarMsg Sidebar.Msg
    | WidgetMsg Widget.Msg
```

### 表示

```elm
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.App.map➊ WidgetMsg➋ (Widget.view➌ model.widgetModel➍)
        ]
```

メインアプリケーションの `view`は`Widget.view`をレンダリングします。しかし、 `Widget.view`は`Widget.Msg`を送出するので、 `Main.Msg`を送出するこのビューと互換性がありません。

- `Html.App.map`➊を使用して、放出されたメッセージをWidget.viewから期待されるタイプ(Msg)にマッピングします。 `Html.App.map`タグは`WidgetMsg`タグを使ってサブビューから来るメッセージにタグを付けます。
- 子コンポーネントが気にするモデルの部分、つまり `model.widgetModel`のみを渡します。

### 更新

```elm
update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
    case message of
        WidgetMsg➊ subMsg➋ ->
            let
                (updatedWidgetModel, widgetCmd)➍ =
                    Widget.update➌ subMsg model.widgetModel
            in
                ({ model | widgetModel = updatedWidgetModel }, Cmd.map➎ WidgetMsg widgetCmd)
```

`WidgetMsg`➊が`update`によって受け取られると、子コンポーネントに更新を委譲します。しかし子コンポーネントは自分が担当する`widgetModel`属性だけを更新します。

パターンマッチングを使用して `WidgetMsg`から`subMsg`➋を抽出します。この `subMsg`は`Widget.update`が予期する型になります。

この `subMsg`と`model.widgetModel`を使って、 `Widget.update`➌を呼び出します。これは更新された `widgetModel`とコマンドを含むタプルを返します。

`Widget.update`からの応答を分解➍するためにパターンマッチングを使います。

最後に、 `Widget.update`によって返されたコマンドを正しい型に対応付ける必要があります。このために `Cmd.map`➎を使い、`WidgetMsg`でコマンドにタグを付けます。これは、ビューで行ったのと同様です。
