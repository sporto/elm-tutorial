> Cette page couvre Elm 0.18

# Préparation

Nous allons construire une application de base pour un jeu de rôle imaginaire.

### Ressources

Durant le reste de ce guide, je vais utiliser le mot __ressources__ pour faire référence aux modèles qui sont les sujets de notre application : dans notre cas, il s'agit des __joueurs__. Le mot __modèle__ peut créer de la confusion car l'état spécifique d'un composant est aussi un modèle (par exemple, l'état ouvert/fermé d'un composant).

## Prototypes

L'application aura deux vues :

![Plan](01-preparation.png)

### Écran 1

Cet écran affiche une liste des joueurs. Depuis cet écran, on peut :

- naviguer vers l'écran d'édition d'un joueur

### Écran 2

Cet écran permet d'éditer un joueur. Depuis cet écran, on peut :

- changer le niveau


Il s'agit d'une application très simple, qui permettra d'illustrer :

- des vues multiples
- les composants imbriqués
- comment décomposer l'application en ressources
- le routage
- un état partagé entre les composants de l'application
- les opérations de lecture et d'écriture sur les enregistrements (*records*)
- les requêtes AJAX
