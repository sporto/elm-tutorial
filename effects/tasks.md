# Tasks

In Elm, __tasks__ allow us to make asynchronous operations. A task might success or fail. They are similar to promises in JavaScript.


Let's start with an application that displays a message every second:

```elm
import Html
import Time

clockSignal : Signal Time.Time
clockSignal =
  Time.every Time.second

messageSignal : Signal String
messageSignal = 
  Signal.map (\x -> toString x) clockSignal

view : String -> Html.Html
view message =
  Html.text message

main: Signal.Signal Html.Html
main =
  Signal.map view messageSignal
```


You can read more about tasks [in the official site](http://elm-lang.org/guide/reactivity).