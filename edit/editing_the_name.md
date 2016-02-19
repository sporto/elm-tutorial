
# Editing the name

The last step of our tutorial application will be to edit the player's name.

## Players Action

Create a new action in __src/Players/Actions.elm__:

```elm
  ...
  | ChangeName PlayerId String
```

## View

In __src/Players/Edit.elm__ let's trigger this action.

The `Html.Events` modules has convenient functions like `onKeyUp` and `onKeyDown`. But is lacking a function to handle a change on an input field (a `change` event on an input field triggers only when the user hits enter or moves the focus out).

### onKeyUp

A function like `onKeyUp` has the following signature:

```
Signal.Address a -> (Int -> a) -> Html.Attribute
```

This function:

- Takes an address of any type, represented by `a`
- A function that takes a string and returns a type `a`
- And returns an `Html.Attribute`

This function can be used like this:

```elm

type Action = DoSomething Int

input
    [ onKeyUp address DoSomething ]
    []
```

As said before `onKeyUp` takes an address and a function `(Int -> a)`. In this case `DoSomething` is our function ``(Int -> a)`.




Add a new function:

```elm
onChange : Signal.Address a -> (String -> a) -> Attribute
onChange address action =
  on "change" targetValue (\str -> Signal.message address (action str))
```

This function takes two parameters:



Then this function returns an `Html.Attribute`.
