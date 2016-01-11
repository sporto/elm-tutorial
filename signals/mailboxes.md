# Mailboxes

`foldp` is an important building block for building applications. Another important building block are Mailboxes.

So far we have been listening to a "raw" signal like `Mouse.x` and using that for displaying information on the page. In a larger application we want to be able to react to the user's interaction with UI elements. For example clicking on a link or button.

In Elm we use __mailboxes__ for this. A mailbox is a communication hub that receives messages from UI elements and tasks and brodcasts a signal.

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

To obtain an __address__, where to send messages to, we need to use a `Mailbox`.

## Mailbox

You create a __mailbox__ like this:

```elm
mb : Signal.Mailbox String
mb =
  Signal.mailbox ""
```

`mb` is a function that returns a `Mailbox`. This specific mailbox deals with strings i.e. it receives messages with strings and returns a signal of strings. 

A NICE DIAGRAM OF A MAILBOX

This function returns the mailbox which is a record with two attributes:

```elm
{ address : Signal.Address a
 signal : Signal.Signal a 
}
```

This record has the `address` we can send messages to and the `signal` that we can listen to.

## Using the mailbox

The next step is to use the mailbox in our application so we can send and refresh messages.


```elm
import Html
import Html.Events as Events

view : Signal.Address String -> String -> Html.Html
view address message =
  Html.div [] [
    Html.div [] [ Html.text message ],
    Html.button [
      Events.onClick address "Hello"
    ] [ Html.text "Click" ]
  ]

mb : Signal.Mailbox String
mb =
  Signal.mailbox ""

main: Signal Html.Html
main =
  Signal.map (view mb.address) mb.signal
```

#### view

The `view` function now takes a `Signal.Address` as first argument.


In `Events.onClick address "Hello"` we use this address to send the "Hello" message to.

#### main

`main` now maps the output signal from our __mailbox__ to the view. But we also pass the __mailbox address__ to the view as the first argument, we do this through partial application `(view mb.address)`.

### Conclusion

Mailboxes are a communication hub, they receive messages from our UI and broadcast them to other parts of our application. A mailbox will become an integral building block for creating a web application.



