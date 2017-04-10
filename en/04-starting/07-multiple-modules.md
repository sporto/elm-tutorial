> This page covers Tutorial v2. Elm 0.18.

# Multiple modules

Our application is growing, so keeping things in one file will quickly become difficult to maintain.

### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies. For example we might have:

- A `Main` module which has a `Player` type on it.
- A `View` module that imports the `Player` type declared in `Main`.
- `Main` importing `View` to render the view.

We now have a circular dependency:

```elm
Main --> View
View --> Main
```

#### How to break it up?

In this case we need to move the `Player` type out of `Main`, to some place where it can be imported by both `Main` and `View`. 

To deal with circular dependencies in Elm, the easiest thing to do is to split your application into smaller modules. In this particular example we can create another module that can be imported by both `Main` and `View`. We will have three modules:

- Main
- View
- Models (contains the Player type)

Now the dependencies will be:

```elm
Main --> Models
View --> Models
```

There is no circular dependency anymore.

Try creating separate modules for things like __messages__, __models__, __commands__ and __utilities__, which are modules that are usually imported by many components.

---

Let's break the application into smaller modules:

First, check your elm-package.json.  Make sure `"source-directories"` points to the directory where our new modules will go.  In this example, it will be the src directory.
```json
    "source-directories": [
        "src"
    ],
```
Now we are ready to create the modules

__src/Msgs.elm__

```elm
module Msgs exposing (..)


type Msg
    = NoOp
```

__src/Models.elm__

```elm
module Models exposing (..)


type alias Model =
    String
```

__src/Update.elm__

```elm
module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

__src/View.elm__

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src/Main.elm__

```elm
module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

You can find the code here <https://github.com/sporto/elm-tutorial-app/tree/018-v02-03-multiple-modules>

---

There are lots of little modules now, which is overkill for a trivial application. But for a bigger application splitting it up makes it easier to work with.


