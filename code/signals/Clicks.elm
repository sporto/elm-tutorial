import Html
import Mouse

view : Int -> Html.Html
view count =
  Html.text (toString count)

countSignal : Signal Int
countSignal =
  Signal.map (always 1) Mouse.clicks

main: Signal.Signal Html.Html
main =
  Signal.map view countSignal
