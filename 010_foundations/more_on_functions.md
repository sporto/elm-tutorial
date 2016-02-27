# More on functions

## Functions as arguments

In many code signatures you will see something like:

```elm
map : (a -> b) -> List a -> List b
```



## Type variables

Consider a function with a type signature like:

```elm
indexOf : String -> Array String -> Int
```

This hypothetical function takes a string and an array of strings and returns the index where the given string was found in the array or -1 if not found.

But what if we instead have an array of integers? We wouldn't be able to use this function. However, we can make this function __generic__ by using __type variables__ instead of specific types of variables.

```elm
indexOf : a -> Array a -> Int
```

By replacing `String` with `a`, the signature now says that `indexOf` takes a value of any type `a` and an array of that same type `a` and returns an integer. As long as the types match the compiler will be happy. You can call `indexOf` with a `String` and an array of `String`, or a `Int` and an array of `Int`, and it will work.

This way functions can be made more generic. You can have several __type variables__ as well:

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

This function takes a tuple of types `a`, `b` and returns a tuple of types `b`, `a`. All these are valid calls:

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```
