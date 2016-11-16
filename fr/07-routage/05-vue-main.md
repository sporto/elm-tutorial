> This page covers Elm 0.17

# Vue Main

La vue de notre application principale doit montrer des pages différentes quand on change l'adresse du navigateur.

Modifiez __src/View.elm__ comme ceci :

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.List
import Players.Edit
import Players.Models exposing (PlayerId)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.App.map PlayersMsg (Players.List.view model.players)

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let
        maybePlayer =
            model.players
                |> List.filter (\player -> player.id == playerId)
                |> List.head
    in
        case maybePlayer of
            Just player ->
                Html.App.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
```

---

### Afficher la bonne vue

```elm
page : Model -> Html Msg
page model =
    case model.route of
        PlayersRoute ->
            Html.App.map PlayersMsg (Players.List.view model.players)

        PlayerRoute id ->
            playerEditPage model id

        NotFoundRoute ->
            notFoundView
```

Désormais, nous avons une fonction `page` qui contient un `case` pour déterminer la vue à afficher selon le contenu de `model.route`.

Quand l'adresse correspondra à la route d'édition de Joueur (par exemple, `#players/2`), on récupèrera l'id du Joueur à partir de la route : `PlayerRoute playerId`.

When the player edit route matches (e.g. `#players/2`) we will get the player id from the route i.e. `PlayerRoute playerId`.

### Trouver le Joueur

```elm
playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    let
        maybePlayer =
            model.players
                |> List.filter (\player -> player.id == playerId)
                |> List.head
    in
        case maybePlayer of
            Just player ->
                Html.App.map PlayersMsg (Players.Edit.view player)

            Nothing ->
                notFoundView
```

On a le `playerId` mais on ne dispose pas pour autant de l'enregistrement du joueur pour cet id. On va donc filtrer la liste des Joueurs pour trouver cet id et utiliser un `case` pour montrer la vue adaptée, selon qu'on aura ou non trouvé le Joueur dans la liste.
