# Introduction to signals

Signals in Elm are one of the basic building blocks for creating applications. You can think of as a signal as a stream of values that change over time.

Signals in Elm can merged, transformed, filtered as you see fit.

![Signal](../../assets/signals/signal.png)

Let's see a basic signal:

```elm
import Html
import Mouse

view : Int -> Html.Html
view x =
  Html.text (toString x)

main : Signal.Signal Html.Html
main =
  Signal.map view Mouse.x
```

If you run this example in the browser you will see the changing `x` coordinate as you move your mouse.

In the first line we are importing the Html module from core, which we will use to display the `x` coordinate.

In the second line we import `Mouse` from core, this module has various utilities for working with the mouse.

#### view

`view` is a function that takes an integer and returns an html fragment (`Int -> Html.Html`).

But `Html.text` takes a string, so we need to convert `x` to a string first. This is done with the `toString` function.

#### main

In Elm applications `main` can return a static element or a signal. In this case `main` is returning a signal of Html (`Signal.Signal Html.Html`). 

Let's deconstruct the last line.

#### Mouse.x

`Mouse.x` gives us a signal of the x mouse coordinate as it changes. This signal has the signature `Signal.Signal Int`, so it is a signal that carries an integer.

#### Signal.map

`Signal.map` is a function that __converts__ or __maps__ one signal to a different signal. The first argument of map is a function that will receive the values from the source signal. In this case the `view` function we defined above. The second argument is the source signal.

Signal.map returns a new signal with the result of mapping the source signal through the provided function.

Here is another example of map:

```elm
double x =
  x * 2

doubleSignal =
  Signal.map double Mouse.x
```

`double` is a function that doubles the input. So `doubleSignal` is a signal that gives us the current mouse x coordinate multiplied by 2.

### Excersice

Try combining the basic mouse x example above with `doubleSignal` so you see the current `x` multiplied by 2 as you move.