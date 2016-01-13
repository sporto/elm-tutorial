# StartApp

In this chapter we have added:

- A __Model__ for keeping the state of our application
- An __update__ function to centralise changes
- __actions__ so we can handle different user actions
- A __mailbox__ so we have a central place where to send messages to

This pattern for organising an Elm application is referred as the __Elm architecture__. This pattern is so useful that there is an elm package called __StartApp__ built just for this. __StartApp__ abstracts the common parts of the pattern:

- Creating a mailbox
- Mapping our signals through `foldp`

## Install start app 

Install start app by doing:

```bash
elm package install evancz/start-app
```

## Using start app (simple)

Let's convert our application to use start app:

```elm
import Html
import Html.Events as Events
import StartApp.Simple

type alias Model = {
    count : Int
  }

type Action =
  NoOp |
  Increase

initialModel : Model
initialModel = {
    count = 0
  }

view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div [] [
    Html.div [] [ Html.text (toString model.count) ],
    Html.button [
      Events.onClick address Increase
    ] [ Html.text "Click" ]
  ]

update : Action -> Model -> Model
update action model =
  case action of
    Increase ->
      {model | count = model.count + 1}
    _ ->
      model

main: Signal.Signal Html.Html
main =
  StartApp.Simple.start {
    model = initialModel,
    view = view,
    update = update
  }
```

We have removed two things:

- The __mailbox__
- And the __modelSignal__, which used `foldp`

StartApp provides these two things for us.

Now we start our application by calling the `start` method of __StartApp.Simple__:

```elm
main =
  StartApp.Simple.start {
    model = initialModel,
    view = view,
    update = update
  }
```

Here we provide our __initial model__, our main __view__ and our __update__ function. StartApp will take care of wiring them together (using a mailbox and foldp).

__StartApp.Simple__ may be sufficient for some applications, but there is a problem with it. It doesn't allow for having side effects. Side effects might include sending ajax request, interacting with local storage, changing the browser location, etc.

In the next chapter we will learn about effects and tasks.
