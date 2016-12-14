> Cette page couvre Elm 0.18

# Update Main

Nous avons besoin que notre fonction principale `update` réponde au nouveau message `OnLocationChange`.

Dans __src/Update.elm__ ajoutez une nouvelle branche :

```elm
...
import Routing exposing (parseLocation)

...

update msg model =
    case msg of
        ...
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
```

Ici, lorsque nous recevons un message `OnLocationChange`, nous analysons cette `location` et stockons la route correspondante dans le modèle.
