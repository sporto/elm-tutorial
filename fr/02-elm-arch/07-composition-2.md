# Composition

## Le composant parent

Voici le code du composant parent :

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

Passons en revue les parties importantes de ce code.

### Modèle

```elm
type alias AppModel =
    { widgetModel : Widget.Model ➊
    }
```

Le composant parent a son propre modèle. Un des attributs de ce modèle contient `Widget.Model` ➊. Notez que le composant parent n'a pas besoin de savoir ce que `Widget.Model` est.

```elm
initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel ➋
    }
```

Lorsque nous créons le modèle initial de notre application, nous appelons simplement `Widget.initialModel` ➋.

Si vous aviez à gérer plusieurs composants enfants, vous feriez de même pour chaque, à savoir :

```
initialModel : AppModel
initialModel =
    { navModel = Nav.initialModel,
    , sidebarModel = Sidebar.initialModel,
    , widgetModel = Widget.initialModel
    }
```

Ou nous pourrions aussi avoir de multiples composants enfants du même type :

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

Nous utilisons un __type d'union__ qui encapsule `Widget.Msg` pour indique que ce message appartient à ce composant. Cela permet à notre application de diriger les messages vers les bons composants (ça sera plus clair lorsque que nous verrons la fonction `update`).

Dans une application avec de multiples composants enfants, nous pourrions avoir quelque chose de ce type :

```elm
type Msg
    = NavMsg Nav.Msg
    | SidebarMsg Sidebar.Msg
    | WidgetMsg Widget.Msg
```

### Vue

```elm
view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.App.map➊ WidgetMsg➋ (Widget.view➌ model.widgetModel➍)
        ]
```

La fonction `view` de l'application affiche `Widget.view` ➌. Mais `Widget.view` émet des messages de type `Widget.Msg` qui ne sont pas compatibles avec cette vue, qui elle émet des messages du type `Main.Msg`.

- Nous utilisons `Html.App.map` ➊  pour transformer les messages émis de `Widget.view` vers le type que nous attendons (Msg). `Html.App.map` étiquette les messages venant de la sous-vue en utilisant l'étiquette `WidgetMsg` ➋.
- Nous passons uniquement la partie du modèle qui concerne le composant enfant, à savoir `model.widgetModel` ➍.

### Mise à jour

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

Lorsqu'un `WidgetMsg` ➊  est reçu par `update`, nous déléguons la mise à jour au composant enfant. Mais le composant enfant ne mettra à jour que ce qui l'intéresse, c'est à dire l'attribut `widgetModel` de notre modèle.

Nous utilisons du pattern matching pour extraire le `subMsg` ➋ de `WidgetMsg`. Ce `subMsg` sera du type que `Widget.update` attend.

Nous appelons `Widget.update` ➌ en utilisant notre `subMsg` et notre `model.widgetModel`. Cela va nous retourner un tuple avec un `widgetModel` mis à jour et une commande.

Nous utilisons de nouveau le pattern matching pour déconstruire ➍ la réponse de `Widget.update`.

Enfin, nous avons besoin de faire correspondre la commande retournée par `Widget.update` au type adéquat. Pour ce faire nous utilisons `Cmd.map` ➎ et nous étiquetons la commande avec `WidgetMsg`, de la même manière que pour la vue.
