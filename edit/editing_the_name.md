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

Add a new function:

```elm
onChange : Signal.Address a -> (String -> a) -> Attribute
onChange address action =
  on "change" targetValue (\str -> Signal.message address (action str))
```

This function takes two parameters:

- takes an address of any type, represented by `a`.
- A function that takes a string and returns a type `a`

Then this function returns an `Html.Attribute`.
