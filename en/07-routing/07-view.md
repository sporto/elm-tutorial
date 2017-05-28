> This page covers Tutorial v2. Elm 0.18.

# Main view

Our main application view needs to show different pages as we change the browser location.

Change __src/View.elm__ to:

```elm
module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId)
import Msgs exposing (Msg)
import Players.Edit
import Players.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
```

---

### Showing the correct view

```elm
page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView
```

Now we have a function `page` which has a case expression to show the correct view depending on what is in `model.route`.

When the player edit route matches (e.g. `#players/2`) we will get the player id from the route i.e. `PlayerRoute playerId`.

### The player edit page

```elm
playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of ➊
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of ➋
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)
```

When navigate to a page we have the `playerId`, but we might not have the list of players loaded or the actual player record for that id in the list. We need to account for this two cases. 

➊ So first we check the type of `model.players`, we will only show the list if this attribute is a `RemoteData.Success list`.

➋ Then we filter the players' list by that id and have a case expression that show the correct view depending if the player is found or not.

### notFoundView

`notFoundView` is shown when no route matches. Note the type `Html msg` instead of `Html Msg`.

### Html Msg vs Html msg

Many times you will see `Html Msg` and many other times `Html msg`. The difference is that `Msg` is a concrete type and `msg` is a type variable.

__Html Msg__

`Html Msg` means a view that returns Html with a concrete message type. For example:

```elm

type Msg = Increase

view : Model -> Html Msg
view model =
    button [ onClick Increase ] [ text "Increase" ]
```

Here `Increase` is a concrete type, our view emits messages of this type, this is reflected in the signature by using `Html Msg`.

__Html msg__

`Html msg` is a generic type, we use this when we don't need to specify the concrete type for a view.

```
view : Model -> Html msg
view model =
    div [] [ text "Hello" ]
```

This view doesn't emit messages, so we can use `Html msg` in the signature. This makes the view more reusable.
