> Cette page couvre Elm 0.18

# Mise à jour des joueurs

Pour finir, nous devons prendre en compte les nouveaux messages dans notre fonction `update`. Ajoutez un nouvel import dans __src/Players/Update.elm__ :

```elm
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)
```

## Créer les commandes de mise à jour

Ajoutez une nouvelle fonction pour vous aider à créer des commandes permettant de sauvegarder un joueur avec l'API.

```elm
changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players
```

Cette fonction sera appelée lorsque nous recevrons un message de type `ChangeLevel`. Cette fonction :

- Reçoit l'id du joueur et la différence de niveau à appliquer (augmentation / diminution)
- Reçoit une liste de joueurs existants
- Parcourt chacun des joueurs de la liste en comparant son id avec l'id du joueur que nous souhaitons modifier
- Si l'id est celui que nous cherchons alors nous retournons une commande pour changer le niveau de ce joueur
- Puis nous finissons par retourner une liste de commandes à exécuter.

## Mettre à jour les joueurs

Ajoutez une autre fonction pour mettre à jour un joueur lorsque que nous recevons une réponse du serveur :

```elm
updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
```

Cette fonction va être utilisée lorsque nous recevrons de l'API un joueur mis à jour via `SaveSuccess`. Cette fonction :

- Prend en paramètre le joueur mis à jour et une liste de joueurs existants.
- Parcourt chacun des joueurs en comparant son id id à celui du joueur mis à jour
- Si les ids correspondent alors nous retournons le joueur mis à jour, sinon nous retournons le joueur existant

## Ajouter des branches à la fonction update

Ajoutez de nouvelles branches à la fonction `update` :

```elm
update message players =
    case message of
        ...

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        OnSave (Ok updatedPlayer) ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        OnSave (Err error) ->
            ( players, Cmd.none )
```

- Dans `ChangeLevel` nous faisons appel la fonction `changeLevelCommands` que nous avons définie plus haut. Cette fonction retourne une liste de commandes à exécuter, c'est pourquoi nous les regroupons en une seule grâce à `Cmd.batch`.
- Dans `OnSave (Ok updatedPlayer)` nous faisons appel à la fonction `updatePlayer` qui va mettre à jour le bon joueur dans la liste.

---

# Essayez par vous-même

Voilà tout ce dont nous avons besoin pour changer le niveau d'un joueur. Essayez par vous-même, rendez-vous sur la vue d'édition et clickez les boutons - et +. Vous devriez voir les niveaux changer et si vous rafraichissez votre navigateur les changements devraient avoir été persistés sur le serveur.

À ce stade votre code devrait ressembler à ça : <https://github.com/sporto/elm-tutorial-app/tree/018-08-edit>.
