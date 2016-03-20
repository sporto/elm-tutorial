# Main

The __src/Main.elm__ module also needs to be change. Without this the router won't do anything.

Import the `Routing` module:

```elm
...
import Routing
```

Back when defining Routing we added a `signal` function. This signal carries all events coming from the router. For example showing a new view when the location changes.

We need to map this signal to an action that our Main module can use. Add a function:

```elm
routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction router.signal
```

This signal needs to be an input for StartApp. Change the `app` definition to:

```
app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal ]
    , update = update
    , view = view
    }
```

Note `inputs = [ routerSignal ]`.

Finally in order to get location changes on the browser we need to tell Elm to run tasks coming from the router. Add a port for this:

```elm
port routeRunTask : Task.Task () ()
port routeRunTask =
  router.run
```

__src/Main.elm__ should look like <https://github.com/sporto/elm-tutorial-app/blob/060-routing/src/Main.elm>
