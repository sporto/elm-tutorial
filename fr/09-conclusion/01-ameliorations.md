# Améliorations

Voici une liste des améliorations que vous pouvez essayer d'appliquer à cette application.

## Créer et supprimer des joueurs

J'ai volontairement laissé cela de côté pour garder le tutoriel court, mais c'est pour sûr une fonctionnalité importante.

## Changer le nom d'un joueur

## Montrer un message d'erreur lorsqu'une requête Http échoue

Actuellement, lorsque la récupération ou la sauvegarde des joueurs échoue, nous ne faisons rien. Il serait bien d'afficher un message d'erreur à l'utilisateur.

## Améliorer les messages d'erreur

Encore mieux que juste montrer les messages d'erreur, ça serait top de :

- Afficher types de messages flash : erreur et info par exemple
- Afficher plusieurs messages flash en même temps
- Avoir la possibilité de rejeter un message
- Supprimer un message automatiquement après quelques secondes

## Mises à jour optimistes

Actuellement, toutes les fonctions de mise à jour sont pessimistes. Cela signifie qu'elles ne changent pas les modèles tant qu'il n'y a pas eu de réponse réussie du serveur. Une grosse amélioration serait d'ajouter la création, la mise à jour et la suppressions optimistes. Mais cela requiert aussi de mieux gérer les erreurs.

## Validations

Nous devrions éviter d'avoir des joueurs sans nom. Une belle fonctionnalité serait d'avoir une validation sur le nom du joueur de manière à ce qu'il ne puisse être vide.

## Ajouter des avantages et des bonus

Nous pourrions ajouter une liste d'avantages qu'un joueur pourrait détenir. Ces avantages pourraient êtres des équipements, des vêtements, des manuscrits, des accessoires, … « Une épée en fer » pourrait en être un par exemple. Nous aurions alors des associations entre les joueurs et les avantages.

Chaque avantage pourrait avoir un bonus associé. Les joueurs auraient alors une _force_ qui serait calculée en additionnant leur niveau avec tous les bonus dont ils disposent.

---

Pour une version de cette application plus riche en fonctionnalités, n'hésitez pas à consulter la branche master de <https://github.com/sporto/elm-tutorial-app>.
