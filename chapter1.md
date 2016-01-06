# Functions

This chapter covers basic Elm syntax that is important to get familiar with: Functions, signatures, the pipe operator and binding.

Let's have a look at a function in Elm:

```elm
add : Int -> Int -> Int
add num1 num2 =
  num1 + num2
```

The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your clearer.

This function called `add` takes two intergers (`Int -> Int`) and returns another integer (The third `-> Int`).