# Routing

Create a module __src/Routing.elm__ for defining the application routing configuration. 

In this module we define:

- the routes for our application
- how to match browser paths to routes using path matchers
- how to react to routing messages

In __src/Routing.elm__:

```elm
module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Players.Models exposing (PlayerId)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
```

---

Let's go over this module.

### Routes

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

These are the available routes in our application.
`NotFound` will be used when no route matches the browser path.

### Matchers

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]
```

Here we define route matchers. These parsers are provided by the url-parser library.

We want three matchers:

- One for an empty route which will resolve to `PlayersRoute`
- One for `/players` which will resolve to `PlayersRoute` as well
- And one for `/players/id` which will resolve to `PlayerRoute id`

Note that the order is important.

See more details about this library here <http://package.elm-lang.org/packages/evancz/url-parser>.

### Hash parser

```elm
hashParser : Navigation.Location -> Result String Route
hashParser location ➊ =
    location.hash ➋
        |> String.dropLeft 1 ➌
        |> parse identity matchers ➍
```

Each time the browser location changes, the Navigation library will give us a `Navigation.Location` record.

`hashParser` is a function that:

- Takes this `Navigation.Location` record ➊
- Extracts the `.hash` part of it ➋
- Removes the first character (the `#`) 
- Sends this string to `parse` with our defined matchers ➍

This parser returns a `Result` value. If the parser succeeds we will get the matched `Route`, otherwise we will get an error as a string.

### Parser

```elm
parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser
```

The Navigation package expects a parser for the current location, each time the location changes in the browser Navigation will call this parser. We pass our `hashParser` to `Navigation.makeParser`.

### Result to route

```elm
routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
```

Finally when we get a result from the parser we want to extract the route. If all matchers fail we return `NotFoundRoute` instead.
