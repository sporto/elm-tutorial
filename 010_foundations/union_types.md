# Union Types

In Elm __Union Types__ - aka __algebraic data types (ADTs)__- are used for many things as they are incredible flexible. A union type looks like:

```elm
type Answer = Yes | No
```

`Answer` can be either `Yes` or `No`. Union types are useful for making our code more generic.

For example a function that is declared like this:

```elm
respond : Answer -> String
respond =
  ...
```

Can either take `Yes` or `No` as the first argument e.g. `respond Yes` is a valid call.
