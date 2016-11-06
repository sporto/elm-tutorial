# Routage

Créez un module __src/Routing.elm__ pour définir la configuration de routage de l'application.

Dans ce module, on définit :

- les routes de notre application
- la correspondance entre les adresses du navigateur et nos routes
- comment réagir aux messages de routage

Dans __src/Routing.elm__ :

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

Étudions ce module.

### Routes

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

Ce sont les routes disponibles dans notre application.
`NotFound` sera utilisée quand l'adresse du navigateur ne correspondra à aucune route.

### Correspondances

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format PlayersRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        ]
```

On définit des correspondances (_matchers_). Les parsers sont fournis par la bibliothèque `url-parser`.

Il nous faut trois correspondances :

- une pour la route vide, qui correspondra à `PlayersRoute`
- une pour `/players`, qui correspondra aussi à `PlayersRoute`
- et une pour `/players/id`, qui correspondra à `PlayerRoute id`

Remarque : l'ordre des correspondances est important.

Plus de détails sur cette bibliothèque sont disponibles dans sa documentation <http://package.elm-lang.org/packages/evancz/url-parser>.

### Parser du hash

```elm
hashParser : Navigation.Location -> Result String Route
hashParser location ➊ =
    location.hash ➋
        |> String.dropLeft 1 ➌
        |> parse identity matchers ➍
```

À chaque fois que l'adresse du navigateur change, `Navigation` nous donne un enregistrement de type `Navigation.Location`.

`hashParser` est une fonction qui :

- prend cet enregistrement `Navigation.Location` ➊
- en extrait la partie `.hash` ➋
- enlève le premièr caractère (le `#`) ➌
- envoie cette chaîne à `parse` avec nos correspondances ➍

Ce parser renvoie une valeur `Result`. Si le parser a réussi, on obtient la `Route` correspondante, sinon on obtient une erreur sous forme de chaîne.

### Parser

```elm
parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser
```

Le paquet `Navigation` requiert un parser pour son adresse courante, qui sera appelé à chaque changement d'adresse dans le browser. On passe notre `hashParser` à `Navigation.makeParser`.

### De Result à Route

```elm
routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
```

Enfin, lorsque l'on reçoit un résultat du parser, on veut en extraire la route. Si aucune correspondance n'est trouvée, on retourne `NotFoundRoute`.
