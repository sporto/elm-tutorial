# The unit type

The empty tuple `()` is called the __unit type__ in Elm.  It is so prevalent that it deserves some explanation.

Consider a type alias with a __type variable__ (represented by `a`):

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

You can make a function that expects a `Message` with the `body` as a `String` like this:

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

Or a function that expects a `Message` with the `body` as a List of Integers:

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

But what about a function that doesn't need a value in the body? We use the unit type for indicating that the body should be empty:

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

This function takes `Message` with an __empty body__. This is not the same as __any value__, just an __empty__ one. 

So the unit type is commonly used as a placeholder for an empty value.

## Task

A real world example of this is the `Task` type. When using `Task`, you will see the unit type very often.

A typical task has an __error__ and a __result__:

```elm
Task error result
```

- Sometimes we want a task where the error can be safely ignored: `Task () result`
- Or the result is ignored: `Task error ()`
- Or both: `Task () ()`
