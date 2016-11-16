> This page covers Elm 0.17

# Navigation

Ajoutons des boutons pour naviguer entre les vues.

## Messages d'édition de Joueur

Modifiez __src/Players/Messages.elm__ pour inclure deux nouvelles actions :

```elm
...

type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | ShowPlayers
    | ShowPlayer PlayerId
```

Nous avons ajouté `ShowPlayers` et `ShowPlayer`.

## Liste de Joueurs

La liste des joueurs devrait afficher un bouton par utilisateur pour déclencher le message `ShowPlayer`.

Dans __src/Players/List.elm__, ajoutez d'abord `Html.Events`:

```elm
import Html.Events exposing (onClick)
```

Puis ajoutez une nouvelle fonction pour ce bouton, à la fin :

```elm
editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

Ici, on envoie `ShowPlayer` avec l'id du Joueur que l'on souhaite éditer.

Enfin, modifiez `playerRow` pour inclure le bouton :

```elm
playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player ]
        ]
```

## Édition de Joueur

Ajoutons le bouton de navigation à la vue d'édition. Dans __/src/Players/Edit.elm__, ajoutez un import :

```elm
import Html.Events exposing (onClick)
```

Ajoutez une nouvelle fonction à la fin pour le bouton `List` :

```elm
listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
```

On envoie le message `ShowPlayers` quand le bouton est cliqué.

Enfin, ajoutez ce bouton à la liste, en changeant la fonction `nav` :

```elm
nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]
```

## Mise à jour de Joueurs

Pour finir, __src/Players/Update.elm__ doit désormais traiter les nouveaux messages.

```elm
import Navigation
```

Ajoutez deux nouvelles branches au `case` :

```elm
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ (toString id)) )
```

`Navigation.newUrl` renvoie une commande. Quand cette commande sera exécutée par Elm, l'adresse du navigateur changera.

## Testez !

Ouvrez `http://localhost:3000/#players`. Vous devriez voir un bouton `Edit`. Si vous le cliquez, l'adresse devrait changer et vous amener à la vue d'édition.
