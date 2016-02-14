# Showing Errors 2

In the previous article we created a `ShowError` action that populates `errorMessage` in the main model and shows a message in the main view.

__src/Players/Udpate.elm__ looks like:

```elm
update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
  case action of
    ...
    FetchAllDone result ->
      case result of
        Ok players ->
          ( players, Effects.none )

        Err error ->
          ( model.players, Effects.none )
```

In this function we can't set the `errorMessage` which is in the mail model as we are in deeper level. We also can't return a root effect as StartApp expects a PlayersAction. We could however add one more return value to the tuple (see An alternative approach below), but we won't do as it adds too much coupling between our modules.

This is the approach we will take:

- Players Update will receive a model that includes an address where to send a message when an error occurs.
- On error we will send a message to this address.
- The message will go a mailbox that will be an input for our application.
- The main update will then receive the action and set the error message in the main model.


## Players Update

In __src/Players/Update__ change `UpdateModel` to require an address:

```elm
type alias UpdateModel =
  { players : List Player
  , showErrorAddress : Signal.Address String
  }
```

Now we expect a `showErrorAddress` address that can receive a message.

Change the `FetchAllDone` branch so we send a message to this address:

```elm
    ...
    FetchAllDone result ->
      case result of
        Ok players ->
          ( players, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.showErrorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.players, fx )
```


---

## An alternative approach