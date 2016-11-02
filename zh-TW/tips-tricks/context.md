# 內容

典型的 `update` 或 `view` 函式看起來像似：

```elm
view : Model -> Html Msg
view model =
  ...
```

或者

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  ...
```

這在思考上很容易走不過去，你只需要傳遞屬於該元件的 `Model`。有時候你需要額外的資訊且這是很正常的事情。舉例來說：

```elm
type alias Context =
  { model : Model
  , time : Time
  }

view : Context -> Html Msg
view context =
  ...
```

這個函式需要元件的模型外加 `time`，這個定義在他的父模型中。
