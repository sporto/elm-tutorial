import Graphics.Element exposing (..)
import Mouse

double x =
  x * 2

doubleSignal =
  Signal.map double Mouse.x

main =
  Signal.map show doubleSignal
