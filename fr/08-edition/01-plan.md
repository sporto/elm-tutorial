> Cette page couvre Elm 0.18

# Plan

Voici le plan pour changer le niveau d'un joueur :

![Flow](01-plan.png)

(1) Lorsque l'utilisateur clique sur le bouton _increase_ ou _decrease_ nous déclenchons un message `ChangeLevel` avec comme données attachées `playerId` et `howMuch`.

(2) __Html.program__ (que `Navigation` encapsule) va en retour envoyer ce message à `Main.Update` qui va le diriger vers `Players.Update` (3).

(4) `Players.Update` va retourner une commande pour sauvegarder le joueur, cette commande transite jusqu'à __Html.program__ (5).

(6) Le runtime Elm exécute la commande (déclenche un appel d'API) et nous allons alors recevoir un résultat : une sauvegarde réussie ou un échec. Dans le cas d'une réussite, nous déclenchons un message `SaveSuccess` avec le joueur mis à jour en paramètre.

(7) `Main.Update` redirige le message `SaveSuccess` vers `Players.Update`.

(8) Dans `Players.Update` nous mettons à jour le modèle `players` et le retournons. Cela retourne ensuite dans Html.program. (9).

(10) Alors, Html.program va afficher l'application avec le modèle mis à jour.
