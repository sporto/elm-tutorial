# Contexts

Typical `update` or `view` functions look like:

```elm
view : Model -> Html Msg
view model =
  ...
```

Or

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  ...
```

It is very easy to get stuck in thinking that you need to pass only the `Model` that belongs to this component. Sometimes you need extra information and is perfectly fine to ask for it. For example:

```elm
type alias Context =
  { model : Model
  , time : Time
  }

view : Context -> Html Msg
view context =
  ...
```

This function asks for the component model plus a `time` which is defined in its parent's model.

