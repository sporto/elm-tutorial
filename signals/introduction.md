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

`main` 