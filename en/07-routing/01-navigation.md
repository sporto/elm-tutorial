# Navigation

Let's add a routing to our application. We will be using the [Elm Navigation package](http://package.elm-lang.org/packages/elm-lang/navigation/1.0.0/) and [Hop](https://github.com/sporto/hop) version 5.0.

- Navigation provides the means to change the browser location and respond to changes
- Hop provides route matchers

First install the packages:

```
elm package install elm-lang/navigation 1.0.0
elm package install sporto/hop 5.0.0
```

## Routing

Create a module __src/Routing.elm__ for defining the application routing configuration. 

In this module we define:

- the routes for our application
- how to match browser paths to routes using path matchers
- how to react to routing messages

Please read the comments to understand what this code does. It should be clear from the comments. In __src/Routing.elm__:

```elm
module Routing exposing (..)

import Navigation
import Hop exposing (matchUrl)
import Hop.Types exposing (Config, Location, PathMatcher, Router, newLocation)
import Hop.Matchers exposing (match1, match2, match3, int)
import Messages exposing (Msg)
import Players.Models exposing (PlayerId)


{-|
   Available routes in our application.
   NotFound is necessary when no route matches the browser path.
-}
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


{-|
   Create a routing model where to store the current location and route
-}
type alias Model =
    { location : Location
    , route : Route
    }


{-|
   Route matchers

   This are in charge of matching the browser path to our routes defined above.
   e.g. "/players" --> PlayersRoute
-}
indexMatcher : PathMatcher Route
indexMatcher =
    match1 PlayersRoute ""


{-|
   This matcher will match "/players" which is the list of players
-}
playersMatcher : PathMatcher Route
playersMatcher =
    match1 PlayersRoute "/players"


{-|
   This matcher will match something like "/players/1"
   Which is the view for a particular player
-}
playerEditMatch : PathMatcher Route
playerEditMatch =
    match2 PlayerRoute "/players/" int


matchers : List (PathMatcher Route)
matchers =
    [ indexMatcher
    , playersMatcher
    , playerEditMatch
    ]


{-|
   Create a router configuration record
   We will use hash routing
   notFound is the message we will receive when there are no matches
-}
routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFoundRoute
    }


{-|
   The Navigation package expects a parser for the current location
   Each time the location changes in the browser this package
   will gives us a Navigation.Location record

  In this parser:

  - We extract the .href attribute from the given Location record
  - Send this attribute to Hop.matchUrl

  Hop.matchUrl will return back a tuple with the matched route
  and a Hop.Types.Location record

-}
parser : Navigation.Parser ( Route, Hop.Types.Location )
parser =
    Navigation.makeParser (.href >> matchUrl routerConfig)

```
