> This page covers Elm 0.18

# Structure of Html.program

### Imports

```elm
import Html exposing (Html, div, text, program)
```

- We will use the `Html` type from the `Html` module, plus a couple of functions `div`, `text` and `program`.

### Model

```elm
type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
```

- First we define our application model as a type alias, in this kind. Here it is just a `String`.
- Then we define an `init` function. This function provides the initial input for the application. 

__Html.program__ expects a tuple with `(model, command)`. The first element in this tuple is our initial state, e.g. "Hello". The second element is an initial command to run. More on this later.

When using the elm architecture, we compose all components models into a single state tree. More on this later too.

### Messages

```elm
type Msg
    = NoOp
```

Messages are things that happen in our applications that our component responds to. In this case, the application doesn't do anything, so we only have a message called `NoOp`.

Other examples of messages could be `Expand` or `Collapse` to show and hide a widget. We use union types for messages:

```elm
type Msg
    = Expand
    | Collapse
```

### View

```elm
view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

The function `view` renders an Html element using our application model. Note that the type signature is `Html Msg`. This means that this Html element would produce messages tagged with Msg. We will see this when we introduce some interaction.

### Update

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

Next we define an `update` function, this function will be called by `Html.program` each time a message is received. This update function responds to messages updating the model and returning commands as needed. 

In this example, we only respond to `NoOp` and return the unchanged model and `Cmd.none` (meaning no command to perform).

### Subscriptions

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
```

We use subscriptions to listen for external input to our application. Some examples of subscriptions are:

- Mouse movements
- Keyboard events
- Browser location changes

In this case, we are not interested in any external input so we use `Sub.none`.

### Main

```elm
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Finally `Html.program` wires everything together and returns an html element that we can render in the page. `program` takes our `init`, `view`, `update` and `subscriptions`.






 
