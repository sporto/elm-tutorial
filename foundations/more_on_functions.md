# More on functions

## Type variables

Consider a function with a type signature like:

```elm
indexOf : String -> Array String -> Int
```

This hypothetical function takes a string and array of strings and returns the index where the given string is in the array or -1 if not found.

But what if we have an array of integers instead. We won't be able to use this function. We can make this function __generic__ by using __type variables__ instead.

```elm
indexOf : a -> Array a -> Int
```

We replaced `String` with `a`. So the signature is now saying that this function takes any type and an array of that same type and returns an integer. As long as the types match the compiler will be happy. You can call this function with a `String` or a `Int` and it will be work.

In this way we can make function more generic. You can have several __type variables__ as well:

```elm
switch : (a, b) -> (b, a)
switch (x, y) =
  (y, x)
```

This function takes a tuple of types `a`, `b` and returns a tuple of types `b`, `a`.

