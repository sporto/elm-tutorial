# More on functions

## Type variables

Consider a function with a type signature like:

```elm
indexOf : String -> List String -> Int
```

This hypothetical function takes a string and a list of strings and returns the index where the given string was found in the list or -1 if not found.

But what if we instead have a list of integers? We wouldn't be able to use this function. However, we can make this function __generic__ by using __type variables__ or __stand-ins__ instead of specific types.

```elm
indexOf : a -> List a -> Int
```

By replacing `String` with `a`, the signature now says that `indexOf` takes a value of any type `a` and a list of that same type `a` and returns an integer. As long as the types match the compiler will be happy. You can call `indexOf` with a `String` and a list of `String`, or an `Int` and a list of `Int`, and it will work.

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

Note that any lowercase identifier can be used for type variables, `a` and `b` are just a common convention. For example the following signature is perfectly valid:

```
indexOf : thing -> List thing -> Int
```

## Functions as arguments

Consider a signature like:

```elm
map : (Int -> String) -> List Int -> List String
```

This function:

- takes a function: the `(Int -> String)` part
- a list of integers
- and returns a list of strings

The interesting part is the `(Int -> String)` fragment. This says that a function must be given conforming to the `(Int -> String)` signature.

For example, `toString` from core is such function. So you could call this `map` function like:

```elm
map toString [1, 2, 3]
```

But `Int` and `String` are too specific. So most of the time you will see signatures using stand-ins instead:

```elm
map : (a -> b) -> List a -> List b
```

This function maps a list of `a` to a list of `b`. We don't really care what `a` and `b` represent as long as the given function in the first argument uses the same types.

For example, given functions with these signatures:

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

We can call the generic map like:

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
