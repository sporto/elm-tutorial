# Structure d'Html.App

### Imports

```elm
import Html exposing (Html, div, text)
import Html.App
```

- Nous allons utiliser le type `Html` du module `Html`, plus d'autres fonctions comme `div` et `text`.
- Nous importons aussi `Html.App` qui est la glu qui orchestrera toute notre application. C'est l'équivalent de StartApp si vous avez déjà utilisé Elm 0.16.

### Modèle

```elm
type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
```

- Premièrement nous définissons notre modèle d'application avec un alias de type. Ici, c'est juste un `String`.
- Ensuite, nous définissions une fonction `init`. Cette fonction fournit les données initiales de notre application.

__Html.App__ attend un tuple du type `(model, command)` pour la fonction init. Le premier élément de ce tuple est notre état de départ, à savoir "Hello". Le second élément est une commande à exécuter. Nous reviendrons là dessus un peu plus tard.


Lorsque nous utilisons l'architecture Elm, nous regroupons tous les modèles de composants au sein d'un seul arbre d'état. Nous y reviendrons aussi plus tard.

### Messages

```elm
type Msg
    = NoOp
```

Les messages sont des choses qui arrivent au sein de notre application et auxquelles notre composant doit répondre. Dans notre cas, l'application ne faisant rien de particulier, nous avons uniquement un message nommé `NoOp` (No Operation).

D'autres messages pourraient être `Expand` (développer) ou `Collapse` (plier) pour montrer ou cacher un widget. Nous utilisons des types d'union pour ces messages :

```elm
type Msg
    = Expand
    | Collapse
```

### Vue

```elm
view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

La fonction `view` affiche un élément Html en utilisant le modèle de notre application. Notez que la signature de la fonction `view` est `Html Msg`. Cela signifie que cet élément Html va produire des messages taggés avec Msg. Nous allons étudier cela lorsque que nous introduirons un peu d'interaction dans notre application.

### Mise à jour

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

Ensuite nous définissons la fonction de mise à jour `update`, cette fonction va être appelée par Html.App à chaque fois qu'un message est reçu. Cette fonction `update` répond aux messages en mettant à jour le modèle et en retournant des commandes à exécuter.

Dans cet exemple, nous répondons uniquement à `NoOp` et retournons le modèle intouché et `Cmd.none` (ce qui signifie aucune commande à exécuter).

### Souscriptions

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
```

Nous utilisons les souscriptions (_subscriptions_) pour écouter les entrées externes à notre application. Voici quelques exemple de souscriptions :

- Mouvements de souris
- Évènements du clavier
- Changement d'url du navigateur

Dans notre cas, nous ne sommes pas intéressés par une quelconque entrée externe, donc nous utilisons `Sub.none`. Notez la signature de la fonction : `Sub Msg`. Les souscriptions d'un composant devraient toutes être de ce même type.

### Main

```elm
main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

Enfin, `Html.App.program` lie le tout et retourne un élément html que nous pouvons afficher dans la page. `program` prend en paramètre nos fonctions `init`, `view`, `update` et `subscriptions`.






 
