# More on functions

## Type variables

Consider a function with a type signature like:

```elm
position : List String -> String -> Int
```

This function 

Sometimes you will see functions like:

```elm
myFunction : List a -> a -> Int
```

`a` is a generic type, it can be replaced with any __comparable__ type. For example a string.