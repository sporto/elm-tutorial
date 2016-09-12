# Function basics

This chapter covers basic Elm syntax that is important to get familiar with: functions, function signatures, partial application and the pipe operator.

## Functions

Elm supports two kind of functions:

- named functions
- anonymous functions

### Named functions

A named function in Elm looks like this:

```elm
add1 : Int -> Int
add1 x =
  x + 1
```

The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your function clearer.
The rest is the implementation of the function. The implementation must follow the signature defined above.

In this case the signature is saying: Given an integer (Int) as argument return another integer.

You call it like:

```
add1 3
```

In Elm we use *whitespace* to denote function application (instead of using parenthesis).

A function that takes no arguments is a constant in Elm:

```elm
name =
  "Sam"
```

### Functions return other functions

A function that takes two arguments looks like:

```elm
add : Int -> Int -> Int
add x y =
    x + y
```

You can think of this signature as a function that takes two integers and returns another integer:

```elm
add 1 2 == 3
```

However, in Elm all functions take exactly one argument and return either another function or a result.

- The first argument is applied returning an intermediate function or a result.
- Then the next argument is applied to that intermediate function returning another function or a result.
- And so on until we run out of arguments to apply.

Let's see an example to understand this:

```elm
add 3 2
```

First the `3` is applied to `add`.
We get an anonymous partially applied function, let's call this intermediate function `add3`.

Then the 2 is applied to that intermediate function, giving the final result 5.

```elm
add3 2
```

Another way to visualise this is by using parenthesis:

```elm
((add 3) 2)
```

The reason we can avoid writing the parenthesis is because function application **associates to the left**.

### Anonymous function

An anonymous function, as its name implies, is a function we create without a name:

```elm
\n -> n + 1
```

Between the backslash and the arrow, you list the arguments of the function, and on the right of the arrow, you say what to do with those arguments.

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
This means you can call a function like `add` above with only one argument, e.g. `add 2` and get a *partially applied function** back.
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
