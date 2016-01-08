# Keeping state

We created a little application that display the current mouse x coordinate. But in most web applications we want to keep some state around as the user interacts with our application. 

Let's create an application that tracks clicks.

```elm
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

```
