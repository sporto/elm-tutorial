> Cette page couvre Elm 0.18

# Introduction au routage

Ajoutons le routage à notre application. Nous utiliserons les paquets [Elm Navigation package](http://package.elm-lang.org/packages/elm-lang/navigation/) et [UrlParser](http://package.elm-lang.org/packages/evancz/url-parser/).

- Navigation permet de changer l'adresse du navigateur et de répondre aux changements
- UrlParser permet de faire correspondre des routes à des actions

D'abord, installez les paquets :

```bash
elm package install elm-lang/navigation
elm package install evancz/url-parser
```

 `Navigation` est une bibliothèque qui enveloppe `Html.program`. Elle a toutes les fonctionnalités de `Html.program` mais permet en plus :

 - d'écouter les changements d'adresse du navigateur
 - déclencher un message lorsque l'adresse change
 - de changer l'adresse du navigateur

## Processus

Voilà quelques diagrammes pour illustrer le fonctionnement de notre routage.

### Affichage initial

![Processus](01-intro.png)

- (1) Quand la page se charge pour la première fois, le module `Navigation` va récupérer la `Location` (l'adresse) actuelle et l'envoyer à la fonction `init` de l'application.
- (2) Dans la fonction `init` nous traitons cette adresse et obtenons une `Route` correspondante.
- (3, 4) Nous stockons cette `Route` correspondante dans notre modèle initial et retournons ce modèle au module `Navigation`.
- (5, 6) `Navigation` affiche ensuite la vue en lui envoyant ce modèle initial.

### Quand l'adresse change

![Processus](01-intro_001.png)

- (1) Quand l'adresse du navigateur change, la bibliothèque `Navigation` reçoit un événement.
- (2) Un message `OnLocationChange` est envoyé à notre fonction `update`. Ce message contiendra la nouvelle `Location`.
- (3, 4) Dans `update` nous  analysons la `Location` et retournons la `Route` correspondante.
- (5) Dans `update` nous retournons le modèle qui contient la `Route` mise à jour.
- (6, 7) `Navigation` affiche ensuite l'application comme d'habitude.
