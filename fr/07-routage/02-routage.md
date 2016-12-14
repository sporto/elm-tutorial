> Cette page couvre Elm 0.18

# Routage

Créez un module __src/Routing.elm__ pour définir la configuration de routage de l'application.

Dans ce module, on définit :

- les routes de notre application
- la correspondance entre les adresses du navigateur et nos routes
- comment réagir aux messages de routage

Dans __src/Routing.elm__ :


```elm
module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


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

Étudions ce module.

### Routes

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

Ce sont les routes disponibles dans notre application.
`NotFoundRoute` sera utilisée quand l'adresse du navigateur ne correspondra à aucune route.

### Correspondances

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]
```

On définit des correspondances (_matchers_). Les parsers sont fournis par la bibliothèque `url-parser`.

Il nous faut trois correspondances :

- une pour la plut haute route (_top_), qui correspondra à `PlayersRoute`
- une pour `/players`, qui correspondra aussi à `PlayersRoute`
- et une pour `/players/id`, qui correspondra à `PlayerRoute id`

Remarque : l'ordre des correspondances est important.

Plus de détails sur cette bibliothèque sont disponibles dans sa documentation <http://package.elm-lang.org/packages/evancz/url-parser>.

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

À chaque fois que l'adresse du navigateur change, `Navigation` va émettre un message contenant un enregistrement de type `Navigation.Location`. Dans notre fonction principale `update`,  nous appellerons `parseLocation` avec cet enregistrement.

`parseLocation` est une fonction qui analyse cet enregistrement `Location` et retourne, si possible, la `Route` correspondante. Si tous les matchers échouent, nous retournons `NotFoundRoute`.

Dans notre cas, nous utilisons `UrlParser.parseHash` puisque nous allons utiliser le hash de l'URL pour nos routes. Nous pourrions appeler `UrlParser.parsePath` à la place pour utiliser le chemin des URLs pour faire le routing.
