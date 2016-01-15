# Signal map with always

Consider mapping a signal to a function:

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
view timestap =
  ...
```

But our view may not care about this timestamp at all. We could ignore it:

```
view _ =
  ...
```


