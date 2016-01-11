import Html

view : String -> Html.Html
view message =
  Html.div [] [
    Html.div [] [ Html.text message ],
    Html.button [] [ Html.text "Click" ]
  ]

messageSignal : Signal String
messageSignal =
  Signal.constant "Hello"

main: Signal Html.Html
main =
  Signal.map view messageSignal
  
