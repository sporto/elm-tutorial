# Introduction to signals

Signals in Elm are one of the basic building blocks for building applications. You can think as a signal as a stream of values that change over time.

Signals in Elm can be passed around, transformed, filtered and combined as you see fit.

Let's see a basic signal:

```elm
import Graphics.Element exposing (..)
import Mouse

main =
  Signal.map show Mouse.x
```

If you run this example in the browser you will see the changing x coordinate as you move your mouse.

In the first line we are importing the Graphics.Element module from core and adding all its functions to our current module (`exposing (..)`). We will be using `show` from this module.

In the second line we import `Mouse` from core, this module has various utilities for working with the mouse.

In Elm applications `main` can take an static element or a signal. In this case `main` is taking a signal. 

Let's deconstruct the last line.

`Mouse.x` gives us a signal of the x mouse coordinate as it changes. This signal has the signature `Signal.Signal Int`, so it is a signal that carries a simple integer.

We cannot display this signal directly, we need to convert it to a different signal for display. `Graphics.Element.show` is a function that __converts anything to its textual representation__, so we will use that.


