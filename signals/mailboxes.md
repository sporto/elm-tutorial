# Mailboxes

`foldp` is an important building block for building applications. Another important building block are Mailboxes.

So far we have been listening to a "raw" signal like `Mouse.x` and using that for displaying information on the page. In a larger application we want to be able to react to the user's interaction with UI elements. For example clicking on a link or button.

In Elm we use __mailboxes__ for this. A mailbox is a communication hub that receives messages from UI elements and tasks and rebrodcasted them as a signal.

To understand this better, let's start by creating a page with a button:

```elm
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
```

`view` display a message and a button for us to click. This button doesn't do anything at the moment.

`messageSignal` is a string signal with the constant value of "Hello", it never changes.