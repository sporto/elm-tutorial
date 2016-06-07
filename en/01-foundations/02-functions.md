# Function basics

This chapter covers basic Elm syntax that is important to get familiar with: functions, function signatures, partial application and the pipe operator.

## Functions

Let's have a look at a function in Elm:

```elm
add : Int -> Int -> Int
add x y =
    x + y
```

The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your function clearer.

This function called `add` takes two integers (`Int -> Int`) and returns another integer (The third `-> Int`).

The second line is the function declaration. The parameters are `x` and `y`.

Then we have the body of the function `x + y` which just returns the sum of the parameters.

You call this function by writing:

```elm
add 1 2
```

### Grouping with parentheses

When you want to call a function with the result of another function call you need to use parentheses for grouping the calls:

```elm
add 1 (divide 12 3)
```

Here the result of `divide 12 3` is given to `add` as the second parameter.

In contrast, in many other languages it would be written:

```js
add(1, divide(12, 3))
```

## Partial application

In Elm you can take a function, like `add` above, and call it with only one argument, e.g. `add 2`.

This returns another function with the value `2` bound as the first parameter. Calling the returned function with a second value returns `2 + ` the second value:

```elm
add2 = add 2
add2 3 -- result 5
```

Another way to think about a function signature like `add : Int -> Int -> Int` is that it is a function that takes one integer as argument and returns another function. The returned function takes another integer and returns an integer.

Partial application is incredibly useful in Elm for making your code more readable and passing state between functions in your application.

## The pipe operator

As shown above you can nest functions like:

```elm
add 1 (multiply 2 3)
```

This is a trivial example, but consider a more complex example:

```elm
sum (filter (isOver 100) (map getCost records))
```

This code is difficult to read, because it resolves inside out. The pipe operator allows us to write such expressions in a more readable way:

```elm
3
    |> multiply 2
    |> add 1
```

This relies heavily on partial application. In this example the value `3` is passed to a partially applied function `multiply 2`. Its result is in turn passed to another partially applied function `add 1`.

Using the pipe operator the complex example above would be written like:

```elm
records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```
