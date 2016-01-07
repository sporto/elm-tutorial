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

#### Mouse.x

`Mouse.x` gives us a signal of the x mouse coordinate as it changes. This signal has the signature `Signal.Signal Int`, so it is a signal that carries a simple integer.

#### Graphics.Element.show

We cannot display this signal directly, we need to convert it to a different signal for display. `Graphics.Element.show` is a function that __converts anything to its textual representation__, so we will use that.

#### Signal.map

`Signal.map` is a function that __converts__ or __maps__ one signal to a different signal. The first argument of map is a function that will receive the values from the source signal. The second argument is the source signal.

Signal.map returns a new signal with the result of mapping the source signal through the provided function.

Here is another example of map:

```elm
double x =
  x * 2

doubleSignal =
  Signal.map double Mouse.x
```

`double` is a function that doubles the input. So `doubleSignal` is a signal that gives us the current mouse x coordinate multiplied by 2.
