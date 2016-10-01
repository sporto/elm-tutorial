# 組成（Composing）

使用 Elm 架構其中一大好處是它處理元件組成的方式。讓我們建構一個範例來了解它：

- 我們有一個父元件 `App`
- 以及一個子元件 `Widget`

## 子元件

讓我們從子元件開始。下列為 __Widget.elm__ 程式碼：

```elm
module Widget exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- 模型


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }



-- 訊息


type Msg
    = Increase



-- 視界


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

此元件與上一章節所做的應用程式幾乎一致，除了訂閱及主程式之外。此元件：

- 定義了自己的訊息（Msg）
- 定義了自己的模型
- 提供處理自己訊息的 `update` 函式，例如：`Increase`。

注意到元件只知道本身定義的東西。`view` 及 `update` 只用元件內所定義的型別（`Msg` 及 `Model`）。

下個章節我們將建立父元件。
