> This page covers Elm 0.17

# Tâches

Nous avons vu comment utiliser les commandes pour rassembler les résultats d'activités impliquant des effets de bord. Pour autant, les commandes n'intègrent pas la notion de succès ou d'échec, ou même d'ordre d'exécution. Les commandes sont juste un tas de choses à faire.

En Elm, on utilise des __tâches__ (*tasks*) pour les opérations asynchrones qui peuvent réussir ou échouer et doivent être enchaînées ("fais ci, puis fais ça"). Les tâches sont comparables aux promesses (*Promises*) en JavaScript.

Une tâche a pour signature : `Task errorValue successValue`. Le premier argument est le type de l'erreur, le second le type de la réussite.

- `Task Http.Error String` est une tâche qui échoue avec un type Http.Error et qui réussit avec un type String
- `Task Never Result` est une tâche qui n'échoue jamais, et qui réussit toujours avec un type `Result`.

Les tâches sont habituellement retournées par des fonctions qui veulent exécuter des opérations asynchrones, comme par exemple envoyer une requête HTTP.

## Lien avec les commandes

Quand on récupère une tâche depuis une bibliothèque, il faut envelopper cette tâche dans une commande pour pouvoir envoyer celle-ci à __Html.App__.

Voyons un exemple. Tout d'abord, il nous faut installer des paquets supplémentaires :

```bash
elm package install evancz/elm-http
```

Et voici l'application :

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

Cette application récupère un nom de planète depuis la swapi (l'API Star Wars). En l'état, elle récupère toujours la planète 1, Tatooine.

---

Jetons-y un oeil :

```elm
type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error
```

On a trois messages :

- `Fetch` pour initier la requête à l'API
- `FetchSuccess` pour si l'on obtient une réponse positive de l'API.
- `FetchError` pour si l'on ne peut pas joindre l'API ou que l'on n'arrive pas à décoder la réponse renvoyée.

### Décodeur JSON

```elm
decode : Decode.Decoder String
decode =
    Decode.at ["name"] Decode.string
```

Ce bout de code crée un décodeur pour les données JSON retournées par l'API. [Cet outil](http://noredink.github.io/json-to-elm/) est incroyablement utile pour créer des décodeurs.

### Tâche

```elm
fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url
```

`Http.get` prend un décodeur et une URL et retourne une tâche.

### Commande de récupération

```elm
fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask
```

On utilise `Task.perform` pour transformer une tâche en commande. Cette fonction prend :

- un constructeur pour le message d'échec
- un constructeur pour le message de succès
- la tâche à exécuter

### Mise à jour

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

Dans la mise à jour, on retourne la commande de récupération quand on initie une récupération (Fetch), et l'on traite les cas de succès et d'erreur.

---

Il y a beaucoup de choses à savoir au sujet des tâches. N'hésitez pas à lire la documentation : <http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Task>.
