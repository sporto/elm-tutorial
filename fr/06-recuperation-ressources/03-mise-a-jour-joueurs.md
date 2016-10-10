# Mise à jour Joueurs

Quand la requête pour les Joueurs est réussie, on envoie le message `FetchAllDone`.

__src/Players/Update.elm__ doit prendre ce message en compte. Modifiez `update` comme suit :

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )
```

Le message `FetchAllDone` a la liste des Joueurs récupérés : on renvoie donc cette donnée pour mettre à jour la collection des Joueurs.

`FetchAllFail` est utilisé en cas d'erreur. Pour l'instant, nous nous contenterons de retourner la liste que nous avions avant la requête qui a échoué.
