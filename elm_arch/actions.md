# Actions

We created an `update` function.

```elm
update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}
```