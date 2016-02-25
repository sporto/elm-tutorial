# Union Types

In Elm __Union Types__ - aka __algebraic data types (ADTs)__- are used for many things as they are incredible flexible. A union type looks like:

```elm
type Answer = Yes | No
```

`Answer` can be either `Yes` or `No`. This `Yes` and `No` are commonly called `tags` in Elm.

Union types are useful for making our code more generic. For example a function that is declared like this:

```elm
respond : Answer -> String
respond answer =
  ...
```

Can either take `Yes` or `No` as the first argument e.g. `respond Yes` is a valid call.

## Payload

Union types can have associated information with them:

```elm
type Answer = Yes | No | Other String
```

In this case the tag `Other` will have an associated string. You could call `respond` like this:

```elm
respond (Other "Hello")
```

You need the parenthesis otherwise Elm will interpret this as passing two arguments to respond.


## Calling as functions

Note how we add a payload to `Other`:

```elm
Other "Hello"
```

This is just like a function call where `Other` is the function. Union types behave just like functions. For example give a type:

```
type Answer = Message Int String
```

You will create a `Message` tag by:

```elm
Message 1 "Hello"
```

You can do partial application just like any other function.


## Nesting

You can nest union types and this is very common as well:


