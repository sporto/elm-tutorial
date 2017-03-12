# Union types

In Elm, __Union Types__ are used for many things as they are incredibly flexible. They are also called ADT (Algebraic Data Types) in other languages. A simple union type looks like:

```elm
type Answer = Yes | No
```

The `Answer` type can be either `Yes` or `No`.

## Type and constructors

A union type has the following components:

```elm
type State = Pending | Done | Failed
    ^----^   ^---------------------^
     type        constructors
```

In this example `State` is the `type`. And `Pending, Done and Failed` are constructors. These are called constructors because you construct a new instance of this type using them. e.g.

```elm
pendingState = Pending
```

## Example

For example a function that has this signature:

```elm
respond : Answer -> String
```

Can either take `Yes` or `No` as the first argument e.g. `respond Yes` is a valid call.

```
respond : Answer -> String
respond answer =
    case answer of
      Yes ->
        ...
      No ->
        ...
```

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

## Used as functions

Note how we add a payload to `Other`:

```elm
Other "Hello"
```

This is just like a function call where `Other` is the function. Union types behave just like functions. For example given a type:

```elm
type Answer = Message Int String
```

You will create a `Message` instance by:

```elm
Message 1 "Hello"
```

You can do partial application just like any other function.

## Nesting

It is very common to 'nest' one union type in another.

```elm
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

Then you can pass this to our `respond` function (which expect `Answer`) like this:

```elm
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

```elm
respond (Other 123)
```

But `respond (Other "Hello")` would fail because `respond` expects an integer in place of `a`.

## A common use

One typical use of union types is passing around values in our program where the value can be one of a known set of possible values.

For example, in a typical web application, we can trigger messages to perform actions, e.g. load users, add user, delete user, etc. Some of these messages would have a payload.

It is common to use union types for this:

```elm
type Msg
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...
```

## Some common union types

There are some common union types in Elm that you will see very often.

```
type Bool = True | False
```

There is no boolean in Elm, it is just a union type.

```
type Maybe a
    = Nothing
    | Just a
```

`Maybe` represents the possibility of having nothing or something.

```
type Result error value
    = Ok value
    | Err error
```

`Result` represents the possibility of having two outcomes from an operation. `Ok` with the associated value and `Err` with the associated error.

---

There is a lot more about Union types. If interested read more about this [here](http://elm-lang.org/guide/model-the-problem).
