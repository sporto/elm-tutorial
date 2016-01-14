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
  Signal.map toString clockSignal

view : String -> Html.Html
view message =
  Html.text message

main: Signal.Signal Html.Html
main =
  Signal.map view messageSignal
```

In you run this in your browser you will see a number that changes slightly every second. This number is the current time (as a unix timestamp).

Let's go through the example:

- `clockSignal` gives a signal that changes every second, the output of this signal is the current timestamp.
- `messageSignal` just converts `clockSignal` to a string.
- `view` takes a string and return html
- `main` maps the `messageSignal` through `view` in order to produce a signal of html, which is what we see.


## Adding a task

Now, instead of displaying the current timestamp every second, we want to get ???TODO

First let's install the __Http__ module, stop Elm reactor, then:

```elm
elm package install evancz/elm-http
elm reactor
```

TODO


You can read more about tasks [in the official site](http://elm-lang.org/guide/reactivity).