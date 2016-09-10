# Function basics

This chapter covers basic Elm syntax that is important to get familiar with: functions, function signatures, partial application and the pipe operator.

## Functions

Elm supports two kind of functions:

- anonymous functions
- named functions

An anonymous function as its name implies is a function we create without a name:

```elm
\n -> n + 1
```

Between the backslash and the arrow, you list the arguments of the function, and on the right of the arrow, you say what to do with those arguments.

Let's have a look at a named function in Elm:

```elm
add : Int -> Int -> Int
add x y =
    x + y
```

The first line in the example is the function signature. This signature is optional in Elm, but recommended because it makes the intention of your function clearer.

One important thing to note is that in Elm you usually work at two different levels:

1. The types level
2. The values level

When writing signatures and types you're working at the type level, but when you are writing functions' implementations you're working at the value level. Knowing at which level you're working on will help you a lot in the understanding of the language.

Let's analyze the function `add` from the two perspectives:

### From the value level

Here we are declaring a function that's going to receive two parameters `x y` and return the sum of those values `x + y`. The important thing to note here is that the parameters, as well as the result, are actual runtime _values_, not compile time types.

### From the type level

Here we can see the use of the special function type `->`, this type usually appears between another two types, the type at its left denotes the input of the function, and the type at its right denotes the output, so `Int -> Int` will read as: the function that takes and `Int` and returns another `Int`.

One important consequence of having such a type for denoting functions is that in Elm, all your functions can receive just one parameter and return just one result, this might sound as a limitation but it's not because Elm functions are higher-order, that is, we can:

1. receive a function as parameter: `(Int -> Int) -> Int` - The parameter is the function `Int -> Int` and the result is `Int`.
2. return a function as the result: `Int -> (Int -> Int)` - The parameter is `Int` and the result is the function `Int -> Int`.

In the second case we can just write `Int -> Int -> Int` because `->` **associates to the right**.

So, how come we can have a function of two parameters at value level but not at type level? The answer is syntax-sugar, our `add` function is just syntax sugar for:

```elm
add : Int -> Int -> Int
add = \x -> (\y -> x + y)
```

### Calling a function

In Elm we use *whitespace* to denote function application (instead of using parenthesis):

```elm
add 1 2
```

But since we saw that functions in Elm can receive just one argument, what's happening is that the previous syntax is desugared into:

```elm
((add 1) 2)
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

Why is that? because since the function application in Elm associates to the left, if we don't use parenthesis in `add 1 divide 12 3` Elm will actually see: `(((add 1) divide) 12) 3` which is a type error because the second argument of `add` must be an `Int` and we're passing it a function `divide`.

## Partial application

In Elm, if you can take a function, like `add` above, and call it with only one argument, e.g. `add 2`, we saw that the result is going to be a function of type `Int -> Int`, having functions work this way gives us the power of partial application for free!

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

This relies heavily on partial application. In this example the value `3` is passed to a partially applied function `multiply 2`. Its result is in turn passed to another partially applied function `add 1`.

Using the pipe operator the complex example above would be written like:

```elm
records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```

Let's analyze the magic behind the pipe operator, which has type: `|> : a -> (a -> b) -> b`, for fun.

We are going to start by analyzing the type of function application in Elm, since we saw its denoted by the whitespace, let's instead use `$` so we don't get confused with whitespace used for separating words.

Instead of using
```elm
add 1 2
```

we are going to use
```elm
add $ 1 $ 2
```

What would be the type of `$`? 
Let's think, its left argument must be a function, its second argument a parameter for that function and its result the result of calling the function on that paramenter. We find then that the type of `$` must be: `$ : (a -> b) -> a -> b`.

Now, let's use the function `flip` defined in Elm's core, the type of this function is: `flip : (a -> b -> c) -> b -> a -> c`, that is, it takes a binary function as its first parameter and returns the same function with the arguments *flipped*.

What's the type of `flip $`? If `$` has type: `$ : (a -> b) -> a -> b` and if `flip` just flips it's parameters, then we get `flip $ : a -> (a -> b) -> b`, notice how this type is the same type `|>` has.

We can use our new `flip $` to rewrite our example as
```elm
2 (flip $) (1 (flip $) add)
```

But it's simpler to just give it a simpler name, such as `|>`
```elm
2 |> (1 |> add)
```

Then we conclude that this magic pipe operator is just a fancy name for *flipped function application*.
