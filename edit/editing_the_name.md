
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

We need to use the generic `on` function instead. Change `inputName` to:

```elm
inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input
    [ class "field-light"
    , value model.player.name
    , on "change" targetValue (\str -> Signal.message address (ChangeName model.player.id str))
    ]
    []
```

Here we added:

```elm
on "change" targetValue (\str -> Signal.message address (ChangeName model.player.id str))
```.


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

As said before `onKeyUp` takes an address and a function `(Int -> a)`. 

In this case `DoSomething` is our function `(Int -> a)`. Remember how types can be called like functions e.g. `DoSomething 1`

### onChange

We would like to have a function `onChange` that behaves just like `onKeyUp`, so we will do just that.

-----


Add a new function:

```elm
onChange : Signal.Address a -> (String -> a) -> Attribute
onChange address action =
  on "change" targetValue (\str -> Signal.message address (action str))
```

This function takes two parameters:



Then this function returns an `Html.Attribute`.
