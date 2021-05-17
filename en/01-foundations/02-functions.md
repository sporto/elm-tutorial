# Function basics

This chapter covers basic Elm syntax that is important to get familiar with: functions, function signatures, partial application and the pipe operator.

## Functions

Elm supports two kind of functions:

- anonymous functions
- named functions

### Anonymous function

An anonymous function, as its name implies, is a function we create without a name:

```elm
\x -> x + 1

\x y -> x + y
```

Between the backslash and the arrow, you list the arguments of the function, and on the right of the arrow, you say what to do with those arguments.


### Named functions

A named function in Elm looks like this:

```elm
addOne : Int -> Int
addOne x =
  x + 1
```

- The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your function clearer.
- The rest is the implementation of the function. The implementation must follow the signature defined above.

In this case the signature is saying: Given an integer (Int) as argument return another integer.

You call it like:

```
addOne 3
```

In Elm we use *whitespace* to denote function application (instead of using parenthesis).

Here is another named function:

```elm
add : Int -> Int -> Int
add x y =
  x + y
```

This function takes two arguments (both Int) and returns another Int. You call this function like:

```elm
add 2 3
```

### No arguments

A function that takes no arguments is a constant in Elm:

```elm
name =
  "Sam"
```

### How functions are applied

As shown above a function that takes two arguments may look like:

```elm
divide : Float -> Float -> Float
divide x y =
    x / y
```

We can think of this signature as a function that takes two floats and returns another float:

```elm
divide 5 2 == 2.5
```

However, this is not quite true, in Elm all functions take exactly one argument and return a result. This result can be another function. 
Let's explain this using the function above.

```elm
-- When we do:

divide 5 2

-- This is evaluated as:

((divide 5) 2)

-- First `divide 5` is evaluated.
-- The argument `5` is applied to `divide`, resulting in an intermediate function.

divide 5 -- -> intermediate function

-- Let's call this intermediate function `divide5`.
-- If we could see the signature and body of this intermediate function, it would look like:

divide5 : Float -> Float
divide5 y =
  5 / y

-- So we have a function that has the `5` already applied.

-- Then the next argument is applied i.e. `2`

divide5 2

-- And this returns the final result
```

The reason we can avoid writing the parenthesis is because function application **associates to the left**.

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

As explained above every function takes only one argument and returns another function or a result.
This means you can call a function like `add` above with only one argument, e.g. `add 2` and get a *partially applied function* back.
This resulting function has a signature `Int -> Int`.

`add 2` returns another function with the value `2` bound as the first parameter. Calling the returned function with a second value returns `2 + ` the second value:

```elm
add2 = add 2
add2 3 -- result 5
```

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

This relies heavily on partial application as explained before. In this example the value `3` is passed to a partially applied function `multiply 2`. Its result is in turn passed to another partially applied function `add 1`.

Using the pipe operator the complex example above would be written like:

```elm
records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```
