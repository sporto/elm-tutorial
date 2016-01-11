# More on functions

## Type variables

Consider a function with a type signature like:

```elm
indexOf : String -> Array String -> Int
```

This hypothetical function takes a string and array of strings and returns the index where the given string is in the array or -1 if not found.

But what if we have an array of integers instead. We won't be able to use this function. We can 


Sometimes you will see functions like:

```elm
myFunction : List a -> a -> Int
```

`a` is a generic type, it can be replaced with any __comparable__ type. For example a string.