# Signal map with always

Consider mapping a signal to a view function:

```elm
clockSignal : Signal Time.Time
clockSignal =
  Time.every Time.second


signal =
  Signal.map view clockSignal
```

`clockSignal` gives us value, i.e. the current timestamp. So then our view will need to receive this value:

```elm
view : Time.Time -> Html.Html
view timestamp =
  ...
```

But our view may not care about this timestamp at all. We could ignore it:

```
view : Time.Time -> Html.Html
view _ =
  ...
```

But we are forcing our view to still get an argument for it `Time.Time`.

It will be better if our view function could just be:

```
view : Html.Html
view =
  ...
```

We can use `always` in the Signal.map to do this:

```elm
signal =
  Signal.map (always view) clockSignal
```

With `(always view)` the value coming from `clockSignal` will be discarded, and view will be called without any arguments.
