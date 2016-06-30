# Union types

In Elm, __Union Types__ are used for many things as they are incredibly flexible. A union type looks like:

```elm
type Answer = Yes | No
```

`Answer` can be either `Yes` or `No`. Union types are useful for making our code more generic. For example a function that is declared like this:

```elm
respond : Answer -> String
respond answer =
    ...
```

Can either take `Yes` or `No` as the first argument e.g. `respond Yes` is a valid call. 

Union types are also commonly called __tags__ in Elm.

## Payload

Union types can have associated information with them:

```elm
type Answer = Yes | No | Other String
```

In this case, the tag `Other` will have an associated string. You could call `respond` like this:

```elm
respond (Other "Hello")
```

You need the parenthesis otherwise Elm will interpret this as passing two arguments to respond.

## As constructor functions

Note how we add a payload to `Other`:

```elm
Other "Hello"
```

This is just like a function call where `Other` is the function. Union types behave just like functions. For example give a type:

```
type Answer = Message Int String
```

You will create a `Message` tag by:

```elm
Message 1 "Hello"
```

You can do partial application just like any other function. These are commonly called `constructors` because you can use this to construct complete types, i.e. use `Message` as a function to construct `(Message 1 "Hello")`.

## Nesting

It is very common to 'nest' one union type in another.

```
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

Then you can pass this to our `respond` function (which expect `Answer`) like this:

```
respond (Other Perhaps)
```

## Type variables

It is also possible to use type variables or stand-ins:

```elm
type Answer a = Yes | No | Other a
```

This is an `Answer` that can be used with different types, e.g. Int, String.

For example, respond could look like this:

```elm
respond : Answer Int -> String
respond answer =
    ...
```

Here we are saying that the `a` stand-in should be of type `Int` by using  the `Answer Int` signature.

So later we will be able to call respond with:

```
respond (Other 123)
```

But respond `(Other "Hello")` would fail because `respond` expects an integer in place of `a`.

## A common use

One typical use of union types is passing around values in our program where the value can be one of a known set of possible values. 

For example, in a typical web application, we have actions that can be performed, e.g. load users, add user, delete user, etc. Some of these actions would have a payload.

It is common to use union types for this:

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...
  
```

---

There is a lot more about Union types. If interested read more about this [here](http://elm-lang.org/guide/model-the-problem).
