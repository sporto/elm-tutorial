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

`main` maps the latest value from `messageSignal` to `view`. So if you run this code on your browser you will see `Hello` which is the constant value coming from `messageSignal`.

## Adding interaction

We want to be able to click on the button and change the message. To do this we use __Html.Events.onClick__. Have a look at the documentation for the __Html.Events__ module. All of them have this signature: `Signal.Address a -> a -> Html.Attribute`

So they take an `Signal.Address` of any type as first argument, that same type as second argument and return an `Html.Attribute`.

But what is an `Address`?

## Addresses

An __address__ is a pointer to an specific signal. It allows us to send __messages__ to that signal.

To obtain an __address__ where to send messages to we need to use a `Mailbox`.

## Mailbox

You create a __mailbox__ like this:

```elm
mb : Signal.Mailbox String
mb =
  Signal.mailbox ""
```

`mb` is a function that returns a `Mailbox`. This specific mailbox deals with strings i.e. it receives messages with strings and returns a signal of strings.