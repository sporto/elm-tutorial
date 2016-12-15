# Hello World

## Installer Elm

Rendez-vous sur <http://elm-lang.org/install> et téléchargez l'installateur approprié pour votre système.

## Notre première application

Écrivons notre première application avec Elm. Créez un répertoire pour accueillir votre application. Dans ce répertoire lancez la commande suivante dans un terminal:

```bash
elm package install elm-lang/html
```

Cette commande va installer le module _html_. Ensuite, ajoutez un fichier `Hello.elm` contentant le code suivant :

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"
```

Déplacez-vous dans le répertoire et tapez :

```bash
elm reactor
```

Voilà ce que vous devriez voir affiché :

```
elm reactor 0.18.0
Listening on http://0.0.0.0:8000/
```

Ouvrez <http://0.0.0.0:8000/>  dans un navigateur et cliquez sur `Hello.elm`. Vous devriez voir `Hello` s'afficher sur votre page.

Il est possible qu'un avertissement s'affiche au sujet d'une annotation de type manquante pour `main`. Ignorez le pour l'instant, nous reviendrons aux annotations de type un peu plus tard.

Passons en revue ce qui se passe ici :

### Déclaration de module

```
module Hello exposing (..)
```

En Elm, chaque module doit commencer par une déclaration de module, dans ce cas le module s'appelle `Hello`. C'est une convention de nommer le fichier et le module de la même manière : le fichier `Hello.elm` contiendra le `module Hello`.

`exposing (..)` spécifie quelle(s) fonction(s) et quel(s) type(s) ce module expose aux autres modules qui l'importe. Dans ce cas particulier, nous exposons tout `(..)`.

### Imports

```
import Html exposing (text)
```

Avec Elm, vous devez importer explicitement les __modules__ que vous souhaitez utiliser. Dans ce cas précis, nous souhaitons utiliser le module __Html__.

Ce module contient tout un tas de fonctions pour travailler avec de l'html. Nous allons utiliser `.text`, donc nous importons cette fonction dans le namespace courant en utilisant `exposing`.

### Programme principal (main)

```
main =
    text "Hello"
```
Le point d'entrée des applications frontend Elm est une fonction nommée `main`. `main` est une fonction qui retourne l'élément à tracer sur la page. Dans notre cas, elle retourne un élément Html (créé en utilisant la fonction `text`).


### Elm reactor

Elm __reactor__ crée un serveur qui compile le code Elm à la volée. __reactor__ est utile lorsque l'on veut développer des applications sans trop se soucier du processus de compilation. Mais __reactor__ a des limitations, c'est pourquoi nous aurons besoin de mettre en place un vrai processus de compilation un peu plus tard. 
