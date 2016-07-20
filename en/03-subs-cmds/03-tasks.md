# Tasks

We have seen how we can use commands to gather results from activities involving side effects. But commands don't have a concept of success or failure. They also don't have the concept of sequencing. Commands are just bags of things to do.

In Elm we use __tasks__ for asynchronous operations that can succeed or fail and need chaining, e.g. do this, then do that. They are similar to promises in JavaScript.

A task has the signature: `Task errorValue successValue`. The first argument is the error type and the second the success type. For example:

- `Task Http.Error String` is a task that fails with an Http.Error or succeeds with a String
- `Task Never Result` is a task that never fails, and always succeeds with a `Result`.

Task are usually returned from functions that want to do async operations, e.g. sending an Http request.

## Relation to commands

When we get a task from a library, we need to wrap that task into a command so we can send the command to __Html.App__.

Let's see an example, first install some additional packages:

```
elm package install evancz/elm-http
```

And here is the application:

```elm
module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App
import Http
import Task exposing (Task)
import Json.Decode as Decode


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



-- MESSAGES


type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Fetch ] [ text "Fetch" ]
        , text model
        ]


decode : Decode.Decoder String
decode =
    Decode.at [ "name" ] Decode.string


url : String
url =
    "http://swapi.co/api/planets/1/?format=json"


fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url


fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetchCmd )

        FetchSuccess name ->
            ( name, Cmd.none )

        FetchError error ->
            ( toString error, Cmd.none )



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
```

This application fetches a planet name from the swapi (Star Wars API). As it is now it always fetches planet 1 which is Tatooine.

---

Let's review it:

```elm
type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error
```

We have three messages. 

- `Fetch` for initiating a request to the API.
- `FetchSuccess` for when we get a successful response from the API.
- `FetchError` when we fail to reach the API or fail to parse the returned response.

### Json decoder

```
decode : Decode.Decoder String
decode =
    Decode.at ["name"] Decode.string
```

This piece of code creates a decoder for the returned Json from the API. For building decoders [this tool](http://noredink.github.io/json-to-elm/) is incredibly valuable.

### Task

```elm
fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url
```

`Http.get` takes a decoder and a url and returns a task.

### Fetch command

```elm
fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask
```

We use `Task.perform` to transform a task into a command. This function takes: 

- A constructor for the failure message
- A constructor for the success message
- And the task to run

### Update

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetchCmd )

        FetchSuccess name ->
            ( name, Cmd.none )

        FetchError error ->
            ( toString error, Cmd.none )
```

In update we return the fetch command when initiating a fetch. And respond to `FetchSuccess` and `FetchError`.

---

There is a lot more to tasks, it is worth browsing the documentation at <http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Task>
