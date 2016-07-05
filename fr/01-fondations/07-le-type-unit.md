# Le type _unit_

Le tuple vide `()` est appelé le __type unit__ en Elm. Il est tellement répandu qu'il mérite quelques explications.

Considérez un alias de type avec une __variable de type__ (représentée par un `a`) :

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

Vous pouvez écrire une fonction qui attend un `Message` avec le champ `body` en tant que `String` de cette manière :

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

Ou une fonction qui attend un `Message` avec le champ `body` comme liste d'entiers :

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

Mais qu'en est-il d'une fonction qui n'a pas besoin de valeur pour `body` ? Nous utilisons le type _unit_ pour indiquer que le `body` devrait être vide :

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

Cette fonction prend un `Message` avec un `body` __vide__. Ce n'est pas pareil que __n'importe quelle valeur__, c'est juste une valeur __vide__.


Ainsi, le type _unit_ est couramment utilisé comme emplacement pour une valeur vide.

## Tâche (Task)

Un exemple concret est le type `Task`. Lorsque vous utiliser `Task`, vous rencontrerez le type _unit_ fréquemment.

Une tâche typique contient une __erreur (error)__ et un __résultat (result)__ :

```
Task error result
```

- Des fois nous voulons une tâche où l'erreur peut être ignorée en tout tranquillité : `Task () result`
- Ou alors le résultat est ignoré : `Tasks error ()`
- Ou les deux : `Task () ()`
