# 組合

## 父元件

下列為父元件程式碼。

```elm
module Main exposing (..)

import Html exposing (Html)
import Html.App
import Widget


-- 模型


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



-- 訊息


type Msg
    = WidgetMsg Widget.Msg



-- 視界


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



-- 訂閱


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- 應用程式


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

---

細察程式碼重要的部份。

### 模型

```elm
type alias AppModel =
    { widgetModel : Widget.Model ➊
    }
```

父元件也有自己的模型。模型內的一個屬性容納 `Widget.Model` ➊。注意到父元件並不清楚 `Widget.Model` 是什麼。

```elm
initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel ➋
    }
```

當應用程式建立初始的模型時，只簡單呼叫 `Widget.initialModel` ➋ 即可。

若有多個子元件，依樣畫葫蘆，如：

```elm
initialModel : AppModel
initialModel =
    { navModel = Nav.initialModel,
    , sidebarModel = Sidebar.initialModel,
    , widgetModel = Widget.initialModel
    }
```

或者，當多個子元件為相同型別：

```elm
initialModel : AppModel
initialModel =
    { widgetModels = [Widget.initialModel]
    }
```

### 訊息

```elm
type Msg
    = WidgetMsg Widget.Msg
```

使用__聯集型別__包裝 `Widget.Msg`，標示為該元件的訊息。這讓應用程式得以轉送訊息到相關元件（看更新函式會清楚一些）。

若應用程式有多個子元件時，可以像這樣做：

```elm
type Msg
    = NavMsg Nav.Msg
    | SidebarMsg Sidebar.Msg
    | WidgetMsg Widget.Msg
```

### 視界

```elm
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.App.map➊ WidgetMsg➋ (Widget.view➌ model.widgetModel➍)
        ]
```

主應用程式 `view` 轉譯 `Widget.view` ➌。但是 `Widget.view` 發出的是 `Widget.Msg`，跟目前視界發出的 `Main.Msg` 並不相容。

- 使用 `Html.App.map` ➊ 將 Widget.view 發出的訊息映射到預期的（Msg）。`Html.App.map` 將來自於子視界訊息加上 `WidgetMsg` ➋  標籤
- 只傳遞子元件所關心的部份模型進去，換言之就是 `model.widgetModel` ➍。

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

當 `update` 收到 `WidgetMsg` ➊ 時，將會委派給子元件。子元件只會更新它所關心的部份，亦即模型的 `widgetModel` 屬性。

使用樣式對應將 `subMsg` ➋ 從 `WidgetMsg` 之中取出。`subMsg` 將會是 `Widget.update` 所預期的型別。

使用 `subMsg` 及 `model.widgetModel` 呼叫 `Widget.update` ➌。這會傳回一個 tuple，包含更新後的 `widgetModel` 及一個命令。

再次使用樣式對應解構來自 `Widget.update` 的結果 ➍。

最後，將來自 `Widget.update` 的命令映射成正確的型別。使用 `Cmd.map` ➎ 及 `WidgetMsg` 標籤，類似剛剛在視界的處理。
