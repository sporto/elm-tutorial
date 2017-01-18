> This page covers Elm 0.18

# 조합하기

## 부모 컴포넌트

이제 부모 컴포넌트를 위한 코드입니다.

```elm
module Main exposing (..)

import Html exposing (Html, program)
import Widget


-- MODEL


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



-- MESSAGES


type Msg
    = WidgetMsg Widget.Msg



-- VIEW


view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.map WidgetMsg (Widget.view model.widgetModel)
        ]



-- UPDATE


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case message of
        WidgetMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Widget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )



-- SUBSCRIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- APP


main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

---

코드의 중요한 부분을 다시 확인해 봅시다.

### Model

```elm
type alias AppModel =
    { widgetModel : Widget.Model ➊
    }
```

이 부모 컴포넌트는 자체 모델을 갖고 있습니다. 모델의 속성 중 하나는 `Widget.Model` ➊ 입니다. 부모 컴포넌트가 `Widget.Model` 의 내용에 대해서 알 필요가 없다는 것이 확인됩니다.

```elm
initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel ➋
    }
```

앱의 초기 상태를 만들 때, 그냥 `Widget.initialModel` ➋ 를 호출하면 됩니다.

자식 컴포넌트가 여럿이라면, 이처럼 각각에 대해 똑같이 하면 됩니다:

```elm
initialModel : AppModel
initialModel =
    { navModel = Nav.initialModel,
    , sidebarModel = Sidebar.initialModel,
    , widgetModel = Widget.initialModel
    }
```

자식 컴포넌트들이 같은 타입이라면 이렇게 해도 되겠죠:

```elm
initialModel : AppModel
initialModel =
    { widgetModels = [Widget.initialModel]
    }
```

### 메시지

```elm
type Msg
    = WidgetMsg Widget.Msg
```

`Widget.Msg` 이 해당 컴포넌트에 사용된다는 점을 묶어서 표현하기 위해 __union type__ 을 사용했습니다. 이는 메시지를 관련 컴포넌트로 전달하기 위해서입니다. (update 함수를 보면 이해가 되실 겁니다).

여러 자식 컴포넌트를 가진 앱이라면 이런 식입니다:

```elm
type Msg
    = NavMsg Nav.Msg
    | SidebarMsg Sidebar.Msg
    | WidgetMsg Widget.Msg
```

### 뷰

```elm
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.map➊ WidgetMsg➋ (Widget.view➌ model.widgetModel➍)
        ]
```

부모 `view` 에서도 `Widget.view` ➌ 를 그립니다. 하지만 `Widget.view` 는 `Widget.Msg` 를 생성하므로 `Main.Msg` 로 바꾸어 주어야 합니다.

- `Html.map` ➊ 으로 `Widget.view` 을 매핑합니다 (Msg). `Html.map` 은 하위 뷰의 메시지에 `WidgetMsg` ➋ 태그를 붙입니다.
- 자식 컴포넌트에 필요한 부분만 모델에서 전달하고 있습니다. (`model.widgetModel` ➍)

### 업데이트

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

`WidgetMsg` ➊ 가 `update` 로 오면 자식 컴포넌트의 update 로 보냅니다. `widgetModel` 속성만 보내면 됩니다.

`WidgetMsg` 에서 `subMsg` ➋ 를 패턴 매칭으로 뽑아냅니다. 이 `subMsg` 는 `Widget.update` 에서 전달받는 타입입니다.

이 `subMsg` 와 `model.widgetModel` 로 `Widget.update` ➌ 을 호출합니다. 갱신된 `widgetModel` 과 커맨드가 리턴됩니다.

`Widget.update` 에서 받은 것을 다시 패턴 매칭합니다 ➍.

마지막으로 `Widget.update` 에서 온 커맨드를 매핑해야 합니다. `Cmd.map` ➎ 를 사용하고 `WidgetMsg` 태그를 같이 전달했습니다.
