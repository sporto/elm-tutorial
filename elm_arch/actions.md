# Actions

We created an `update` function.

```elm
update : () -> Model -> Model
update _ model =
  {model | count = model.count + 1}
```

As is, this `update` function can work with only one input signal i.e. `Mouse.clicks` which produces the expected `()` input.

But what we really want if for `update` to be able to handle different actions in our application. For this we will introduce the concept of __actions__ in Elm. We will use __enumerable__ types for this.

```elm
type Action =
  NoOp |
  Increase
```

Here we have an `Action` that can be either be `NoOp` (Do nothing) or `Increase` (Increase the counter).

