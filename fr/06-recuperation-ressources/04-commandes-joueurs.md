> This page covers Elm 0.17

# Commandes Joueurs

Maintenant, il nous faut créer les tâches et les commandes pour récupérer les Joueurs sur le serveur. Créez __src/Players/Commands.elm__ :

```elm
module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)
```
---

Étudions ce code.

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone
```

Ici, on crée une commande exécutable par noter application :

- `Http.get` crée une tâche
- on envoie ensuite cette tâche à `Task.perform`, qui l'enveloppe dans une commande

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

Ce décodeur délègue le décodage de chaque membre de la liste à `memberDecoder`.

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)
```

`memberDecoder` crée un décodeur JSON qui retourne un enregistrement de type `Player`.

---
Pour comprendre le fonctionnement d'un décodeur, utilisons le `REPL` d'Elm.

Dans un terminal, lancez `elm repl`. Importez le module `Json.Decoder` :

```bash
> import Json.Decode exposing (..)
```

Puis, définissez une chaîne Json :

```bash
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

Ainsi qu'un décodeur pour extraire l'`id` :

```bash
> idDecoder = ("id" := int)
```

Cela crée un décodeur qui, lorsqu'on lui donne une chaîne, essaie d'extraire la clef `id` et de l'interpréter comme un entier.

Exécutez le décodeur pour voir le résultat :

```bash
> result = decodeString idDecoder  json
Ok 99 : Result.Result String Int
```

On obtient `Ok 99`, ce qui signifie que le décodage a réussi et que la valeur obtenue est `99`. Voilà la fonction de `("id" := Decode.int)` : créer un décodeur pour une clef.

Tout ça n'est que la première partie du travail. Pour la deuxième partie, définissez un type :

```bash
> type alias Player = { id: Int, name: String }
```

En Elm, on peut créer un enregistrement en appelant un type comme une fonction. Par exemple, `Player 1 "Sam"` crée un enregistrement de Joueur. Note : l'ordre des paramètres est important, comme pour une fonction classique.

Pour essayer, faites :

```bash
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

En utilisant ces deux concepts, créons un décodeur complet :

```bash
> nameDecoder = ("name" := string)
> playerDecoder = object2 Player idDecoder nameDecoder
```

La fonction `object2` prend une fonction (ici, `Player`) en premier argument et deux décodeurs. Puis, elle exécute les décodeurs et passe les résultats en argument à la fonction (`Player`).

Pour essayer, faites :

```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

Rappelez-vous que rien de tout cela n'est vraiment exécuté tant que la commande n'est pas envoyée à __Html.App__.
