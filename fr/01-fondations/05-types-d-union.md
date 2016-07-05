# Types d'union

Avec Elm, les __Types d'Union__ (_Union Types_) sont beaucoup utilisés de part leur incroyable flexibilité. Voici à quoi ressemble un type d'union :


```elm
type Answer = Yes | No
```

`Answer` peut aussi bien ête un `Yes` ou un `No`. Les types d'union sont utiles pour rendre votre code plus générique. Par exemple, une fonction qui est déclarée de cette manière :

```elm
respond : Answer -> String
respond answer =
    ...
```

Peut soit prendre un `Yes` ou un `No` comme premier argument, ce qui veut dire que `respond Yes` est un appel de fonction valide.

Les types d'union sont fréquemment appelés __tags__ en Elm.

## Associer de l'information (Payload)

Les types d'union peuvent être associées à de l'information :

```elm
type Answer = Yes | No | Other String
```

Dans ce cas, le tag `Other` aura une chaine de caractères associé. Vous pourriez appeler `respond` de cette manière :

```elm
respond (Other "Hello")
```

Vous avez besoin de parenthèses car sinon Elm interpréterait cela comme si vous passiez deux arguments à `respond`.

## Comme constructeur de fonctions

Regardez comment nous ajoutons de l'information à `Other` :

```elm
Other "Hello"
```

C'est juste un appel de fonction où `Other` est la fonction. Les types d'union se comportent exactement comme des fonctions. Par exemple avec ce type :

```
type Answer = Message Int String
```

Vous créerez un tag `Message` de cette manière :

```elm
Message 1 "Hello"
```

Il est aussi possible de faire de l'application partielle, comme avec n'importe quelle autre fonction. On appelle cela des `constructeurs` car vous pouvez vous en servir pour construire des types complets. Par exemple utiliser `Message` comme fonction pour construire `(Message 1 "Hello")`.

## Imbrication

Il est très fréquent d'imbriquer un type d'union dans un autre.

```
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

Vous pouvez alors passer cela à notre fonction `respond` (qui attend un `Answer`) de cette manière :

```
respond (Other Perhaps)
```

## Variables de type

Il est aussi possible d'utiliser des variables de type (aussi appelées _stand-in_) :

```elm
type Answer a = Yes | No | Other a
```

C'est un `Answer` qui peut être utilisé avec différents types, comme Int ou String.

Par exemple, `respond` pourrait ressembler à ça :

```elm
respond : Answer Int -> String
respond answer =
    ...
```

Ici nous spécifions que le stand-in `a` devrait être de type `Int` en utilisant la signature `Answer Int`.

Nous serons ensuite capable d'appeler `respond` comme ceci :

```
respond (Other 123)
```

Mais respond `(Other "Hello")` échouera car `respond` s'attend à recevoir un entier en lieu et place de `a`.

## Cas d'usage habituel

Un cas typique d'usage des types d'union est lorsque que l'on souhaite faire transiter des valeurs dans notre programme et que ces valeurs doivent faire partie d'un ensemble connu de possibilités.


Par exemple, dans une application web typique, nous avons des actions qui peuvent être exécutées comme charger des utilisateurs, ajouter des utilisateurs, supprimer des utilisateurs, … Certaines de ces actions peuvent avoir des informations attachées.

Il est habituel d'utiliser des types d'union pour cela :

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...
  
```

---

Il y aurait beaucoup à dire au sujet des types d'union. Si le sujet vous intéresse, vous pouvez lire plus à ce sujet [ici (en anglais)](http://elm-lang.org/guide/model-the-problem).
