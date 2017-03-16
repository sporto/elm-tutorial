> This page covers Tutorial v2. Elm 0.18.

# Models

In __src/Models.elm__ we will define the possible routes for our application. Add a new type:

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

`NotFoundRoute` will be used when no route matches the browser path.

# Routing

Create a module __src/Routing.elm__ for defining the application routing configuration.

In this module we define:

- how to match browser paths to routes using path matchers
- how to react to routing messages

In __src/Routing.elm__:

```elm
module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

---

Let's go over this module.

### Matchers

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]
```

Here we define route matchers. These parsers are provided by the url-parser library.

We want three matchers:

- One for the top route which will resolve to `PlayersRoute`
- One for `/players` which will resolve to `PlayersRoute` as well
- And one for `/players/id` which will resolve to `PlayerRoute id`

Note that the order is important as routes defined first will have priority over later definitions.

See more details about this library here <http://package.elm-lang.org/packages/evancz/url-parser>.

### parseLocation

```elm
parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

Each time the browser location changes, the Navigation library will trigger a message containing a `Navigation.Location` record. From our main `update` we will call `parseLocation` with this record.

`parseLocation` is a function that parses this `Location` record and returns the matched `Route` if possible. If all matchers fail we return `NotFoundRoute`.

In this case we `UrlParser.parseHash` as we will be routing using the hash. You could use `UrlParser.parsePath` to route with the path instead.
