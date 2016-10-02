# 多重（Multiple）模組

我們應用程式成長快速，很快地把所有東西放在一個檔案將變得難以維護。

### 相依循環

另一個可能在某個時間點上會碰到的是相依循環。舉例來說，我們有：

- `Main` 模組有個 `Player` 型別。
- `View` 模組從 `Main` 模組匯入 `Player` 型別。
- `Main` 匯入 `View` 來轉譯視界。

因此造成了相依循環的問題：

```elm
Main --> View
View --> Main
```

#### 如何拆解？

這種情況我們需要將 `Player` 型別從 `Main` 中移走，移到可以同時被 `Main` 及 `View` 所匯入的地方。

Elm 中處理相依循環最簡單的方式就是切割應用程式成更小的模組。這個例子中，我們可以另外新增一個模組給 `Main` 及 `View` 匯入。因此有三個模組：

- Main
- View
- Models（包含了 Player 型別）

現在相依變成了：

```elm
Main --> Models
View --> Models
```

這樣一來就沒有相依循環。

試著分割模組成類似__訊息__、__模型__、__命令__或__工具__，這些模組通常會被許多元件所匯入。

---

讓我們將應用程式切割成更小的模組：

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

__src/View.elm__

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src/Main.elm__

```elm
module Main exposing (..)

import Html.App
import Messages exposing (Msg)
import Models exposing (Model)
import View exposing (view)
import Update exposing (update)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- 主程式


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

你可以在此找到程式碼 <https://github.com/sporto/elm-tutorial-app/tree/03-multiple-modules>

---

現在多了許多小模組，對於不重要的應用程式來說有點殺雞用牛刀。但對於較大的應用程式來說，分割會讓工作更輕鬆。
