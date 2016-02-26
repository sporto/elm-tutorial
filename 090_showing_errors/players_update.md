# Players Update

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
            errorMessage =
              toString error

            fx =
              Signal.send model.showErrorAddress errorMessage
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.players, fx )
```

`Signal.send` creates a task that when run send a message to an address. We are asking to send the `errorMessage` to the `showErrorAddress` address. 

We need to return an effect, not a task, so we convert this task to an effect by using `|> Effect.task`. And the effect needs to be of type Players Action, so we map it to a new action `TaskDone`.

### Players Actions

We need this new `TaskDone` action in __src/Players/Actions.elm:

Add:

```elm
  ...
  | TaskDone ()
```

This action has a payload that we just ignore `()`. 

Back in __src/Players/Update.elm__ this new action `TaskDone` has to be accounted for. Add a new branch:

```
    ...
    TaskDone () ->
      ( model.players, Effects.none )
```

So far:

- We require an address where to send an error message
- On error we return an effect that sends the error message to this address

In the next section we will add the rest of the setup, which means providing this address to Players.Update.

---

## An alternative approach

The Elm architecture is flexible, we don't necessarily have to return always a tuple with two elements in update. So instead of 

```elm
update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
    ...
```

We could return a tuple with three values:

```elm
update : Action -> UpdateModel -> ( List Player, Effects Action, Effects MainAction )
update action model =
    ...
```

The last value could be a root effect. In this way we could call the `ShowError` action that we set in main directly from here. 

However, this adds external knowledge to Players.Update. This module would need to import the Main action and would need to know that `ShowError` exists. This adds tighter coupling, which is not great.

