# StartApp with effects

__StartApp.Simple__ may be sufficient for some application, but there is a problem with it. It doesn't allow for having side effects. Side effects might include:

- Changing the browser route
- Sending an Ajax request

These are definitely necessary things to do when building a web application. We will use the full version of StartApp from now on.

We need to install `elm-effects` for this: 

Stop elm reactor if running and install elm-effects

```bash
elm package install evancz/elm-effects
elm reactor
```

