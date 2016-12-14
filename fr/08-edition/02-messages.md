> Cette page couvre Elm 0.18

# Messages

Commençons par ajouter les messages dont nous allons avoir besoin.

Dans __src/Players/Messages.elm__ ajoutez :

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
```

- `ChangeLevel` va être déclenché lorsque l'utilisateur veut changer le niveau. Le second paramètre est en entier indiquant de combien le niveau doit être changé : -1 pour diminuer ou 1 pour augmenter.
- Ensuite nous allons envoyer une requête à l'API pour mettre à jour le joueur. `OnSave` sera déclenché une fois que la réponse de l'API aura été reçue.
- `OnSave` contiendra, en cas de succès, le joueur mis à jour ou alors l'erreur Http en cas d'échec.
