# Function basics


This chapter covers basic Elm syntax that is important to get familiar with. These are functions, function signatures, partial application and the pipe operator.

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

### Grouping with parenthesis

When you need to call a function which includes the result of another function you will use parentesis to group them:

```elm
add 1 (divide 12 3)
```

Here the result of `divide 12 3` is given to `add` as the second parameter. 

For contrast in many other languages this will be written like:

```js
add(1, divide(12, 3))
```

## Partial application

In Elm you can take a function like `add` above and call it with only one argument e.g. `add 2`.

This will return another function with the first parameter bound to `2`, then you call this returned function with other parameter:

```elm
add2 = add 2
add2 3 ==> 5
```

Another way of thinking about a function signature like `add : Int -> Int -> Int`. Is that this is a function that takes one integer as argument and returns another function. This returned function takes another integer and returns an integer.

Partial application is incredible useful in Elm for making your code more readable and passing state between functions in your application.

## The pipe operator

As shown above you can nest functions like:

```elm
add 1 (multiply 2 3)
```

Maybe this is a trivial example, but conside a more complex one:

```elm
sum (filter (isOver 100) (map getCost records))
```

This could be hard to read as it resolves inside out. The pipe operator makes writing these examples in a more readable way:

```elm
3
  |> multiply 2
  |> add 1
```

```elm
records
  |> map getCost
  |> filter (isOver 100)
  |> sum
```

This relies heavily on partial application, in the first example `3` is passed to a partially applied function `multiply 2`, then that result is passed to another partially applied function `add 1`.