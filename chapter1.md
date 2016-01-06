# Functions


This chapter covers basic Elm syntax that is important to get familiar with. These are functions, function signatures, the pipe operator and auto binding.

## Functions

Let's have a look at a function in Elm:

```elm
add : Int -> Int -> Int
add x y =
  x + y
```

The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your clearer.

This function called `add` takes two intergers (`Int -> Int`) and returns another integer (The third `-> Int`).

The second line is the function declaration. The parameters are `x` and `y`.

Then we have the body of the function `x + y` which just returns the sum of the parameters.

You call this function by writing:

```elm
add 1 2
```

### Parenthesis

When you need to call a function which includes the result of another function you will use parentesis to group them:

```elm

```