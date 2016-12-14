> This page covers Elm 0.18

# Commandes des joueurs

Maintenant, créons les commandes qui vont nous permettre de mettre à jour le joueur via notre API.

Dans __src/Players/Commands.elm__ ajoutez :

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### Requête de sauvegarde

```elm
saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody ➊
        , expect = Http.expectJson memberDecoder ➋
        , headers = []
        , method = "PATCH" ➌
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }
```

➊ Ici nous encodons le joueur passé en paramètre et nous convertissons la valeur encodée en chaîne de caractère JSON.
➋ Ici nous spécifions comment analyser la réponse, dans notre cas nous voulons transformer le JSON retourné en valeur Elm.
➌ `PATCH` est la méthode HTTP que notre API attend pour la mise à jour d'enregistrements.

### Sauvegarde

```elm
save : Player -> Cmd Msg
save player =
    saveRequest player ➊
        |> Http.send OnSave ➋
```

Ici nous créons le requête de sauvegarde ➊ et générons une commande pour envoyer la requête en utilisant `Http.send` ➋. 
`Http.send` prend en paramètre un constructeur de message (`OnSave` dans notre cas). Une fois que la requête est effectuée, Elm va déclencher un message `OnSave` avec le réponse correspondant à la requête.
