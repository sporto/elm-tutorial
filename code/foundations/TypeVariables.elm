import Html
import Array

indexOf : a -> Array.Array a -> Int
indexOf target array =
  -1

switch: (a, b) -> (b, a)
switch (x, y) =
  (y, x)

main =
  Html.text (toString (indexOf 1 (Array.fromList [1, 2])))
  --Html.text (toString (switch ("d", 2)))
