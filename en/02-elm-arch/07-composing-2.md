# Composing

## The parent component

This is the code for the parent component.

```elm
module Main exposing (..)

import Html exposing (Html)
import Html.App
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
        [ Html.App.map WidgetMsg (Widget.view model.widgetModel)
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



-- SUBSCIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- APP


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

Let's review the important sections of this code.

### Model

```elm
type alias AppModel =
    { widgetModel : Widget.Model ➊
    }
```

The parent component has its own model. One of the attributes on this model contains the `Widget.Model` ➊. Note how this parent component doesn't need to know about what `Widget.Model` is.

```elm
initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel ➋
    }
```

When creating the initial application model, we simply call `Widget.initialModel` ➋ from here.

If you were to have multiple children components, you would do the same for each, for example:

```
initialModel : AppModel
initialModel =
    { navModel = Nav.initialModel,
    , sidebarModel = Sidebar.initialModel,
    , widgetModel = Widget.initialModel
    }
```

Or we could have multiple children components of the same type:

```
initialModel : AppModel
initialModel =
    { widgetModels = [Widget.initialModel]
    }
```

### Messages

```elm
type Msg
    = WidgetMsg Widget.Msg
```

We use a __union type__ that wraps `Widget.Msg` to indicate that a message belongs to that component. This allows our application to route messages to the relevant components (This will become clear looking at the update function).

In an application with multiple children components we could have something like:

```elm
type Msg
    = NavMsg Nav.Msg
    | SidebarMsg Sidebar.Msg
    | WidgetMsg Widget.Msg
```

### View

```elm
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.App.map➊ WidgetMsg➋ (Widget.view➌ model.widgetModel➍)
        ]
```

The main application `view` renders the `Widget.view` ➌. But `Widget.view` emits `Widget.Msg` so is incompatible with this view which emits `Main.Msg`.

- We use `Html.App.map` ➊ to map emitted messages from Widget.view to the type we expect (Msg). `Html.App.map` tags messages comming from the sub view using the `WidgetMsg` ➋ tag.
- We only pass the part of the model that the children component cares about i.e. `model.widgetModel` ➍.

### Update

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

When a `WidgetMsg` ➊ is received by `update` we delegate the update to the children component. But the children component will only update what it cares about, which is the `widgetModel` attribute.

We use pattern matching to extract the `subMsg` ➋ from `WidgetMsg`. This `subMsg` will be the type that `Widget.update` expects.

Using this `subMsg` and `model.widgetModel` we call `Widget.update` ➌. This will return a tuple with an updated `widgetModel` and a command.

We use pattern matching again to destructure ➍ the response from `Widget.update`.

Finally we need to map the command returned by `Widget.update` to the right type. We use `Cmd.map` ➎ for this and tag the command with `WidgetMsg`, similar to what we did in the view.
