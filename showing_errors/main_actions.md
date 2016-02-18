# Main Action to show the error

In __src/Actions.elm__ add a new action:

```elm
  ...
  | ShowError String
```

And update __src/Update.elm__ to include this action. Add a new branch to the case expresion:

```elm
    ...
    ShowError message ->
      ( { model | errorMessage = message }, Effects.none )
```

---

Try what we have so far by adding a hard coded error in __src/Models.elm__, add this to `initialModel`:

```
...
  , errorMessage = "Error"
```

Refresh and you should see this error message. Put it back to "".

We have half of the wiring for showing an error message. Now we need some way to trigger this `ShowError` action from Players/Update.




