# Contextes

Les fonctions `view` ou `update` ressemblent habituellement à ça :

```elm
view : Model -> Html Msg
view model =
  ...
```

Ou

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  ...
```

On pourrait facilement penser qu'on ne doit passer que le `Model` qui appartient à ce composant. Parfois, vous aurez besoin de plus d'informations, et il est absolument correct de la réclamer ! Par exemple :

```elm
type alias Context =
  { model : Model
  , time : Time
  }

view : Context -> Html Msg
view context =
  ...
```

Cette fonction utilise le modèle du composant, mais aussi un objet `time` défini dans le modèle de son parent.
