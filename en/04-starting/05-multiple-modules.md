# Multiple modules

Our application is going to grow soon, so keeping things in one file will become hard to maintain quite fast. 

### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies. For example we might have:

- A `Main` module which has a `Player` type on it.
- A `View` module that imports the `Player` type declared in `Main`.
- `Main` importing `View` to render the view.

We now have a circular dependency:

```
Main --> View
View --> Main
```

#### How to break it?

In this case what we need to do is to move the `Player` type out of `Main`, somewhere it can be imported by both `Main` and `View`. 

To deal with circular dependencies in Elm the easiest thing to do is to split your application into smaller modules. In this particular example we can create another module that can be imported by both `Main` and `View`. We will have three modules:

- Main
- View
- Models (contains the Player type)

Now the dependencies will be:

```
Main --> Models
View --> Models
```

There is no circular dependency anymore.

Try creating separate modules for things like __messages__, __models__, __commands__ and __utilities__, which are modules that are usually imported by many components.

---

Let's break the application in smaller modules:

__src/Messages.elm__

```
module Messages exposing (..)


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

import Messages exposing (Msg(..))
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
import Messages exposing (Msg)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

__src/Main.elm__

```elm
module Main exposing (..)

import Html.App
import Messages exposing (Msg)
import Models exposing (Model)
import View exposing (view)
import Update exposing (update)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

You can find the code here <https://github.com/sporto/elm-tutorial-app/tree/03-multiple-modules>

---

There are lots of little modules now, this is overkill for a trivial application. But for a bigger application splitting it makes it easier to work with.


