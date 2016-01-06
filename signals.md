# Signals

Signals in Elm are one of the basic building blocks for building applications. You can think as a signal as a stream of values that change over time.

Signals in Elm can be passed around, transformed, filtered and combined as you see fit.

Let's see a basic signal:

```elm
import Graphics.Element exposing (..)
import Mouse

main =
  Signal.map show Mouse.x
```

## Transforming signals



## Combining signals

## Keeping state

