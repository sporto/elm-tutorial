>このページでは、Elm 0.18

# 合成

Elmアーキテクチャを使用する大きな利点の1つは、コンポーネントを合成する方法です。これを理解するために例を示します。

- 親コンポーネント `App`があります
- その子コンポーネントに`Widget`があります

## 子コンポーネント

子コンポーネントから始めましょう。これは__Widget.elm__のコードです。

```elm
module Widget exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- モデル


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }



-- メッセージ


type Msg
    = Increase



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.count) ]
        , button [ onClick Increase ] [ text "Click" ]
        ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | count = model.count + 1 }, Cmd.none )
```

このコンポーネントは、サブスクリプションとメインを除いて、前のセクションで作成したアプリケーションとほぼ同じです。このコンポーネントは：

- 独自のメッセージ(Msg)を定義します。
- 独自のモデルを定義します。
- 自身のメッセージ(`Increase`など)に応答する `update`関数を提供します。

コンポーネントはここで宣言されたことだけを知っていることに注意してください。 `view`と`update`は両方とも、コンポーネント内で宣言された型(`Msg`と`Model`)のみを使用します。

次のセクションでは、親コンポーネントを作成します。
