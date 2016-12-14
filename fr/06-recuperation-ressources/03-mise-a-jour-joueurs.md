> Cette page couvre Elm 0.18

# Mise à jour Joueurs

Quand la requête pour les Joueurs est réussie, on envoie le message `OnFetchAll`.

__src/Players/Update.elm__ doit prendre ce message en compte. Modifiez `update` comme suit :

```elm
...
update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        OnFetchAll (Err error) ->
            ( players, Cmd.none )
```

Lorsque nous recevons le message `OnFetchAll`, nous pouvons utiliser le pattern matching pour décider la marche à suivre.

Dans le cas `Ok`, nous retournons la liste des joueurs récupérés afin de mettre à jour la collection des joueurs.

Dans le cas `Err`, pour l'instant, nous retournons juste la liste que nous avions auparavant. Une meilleure approche serait d'afficher un message d'erreur à l'utilisateur, mais pour garder ce tutoriel simple, nous avons choisi de ne pas le faire.
