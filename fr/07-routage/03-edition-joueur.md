> Cette page couvre Elm 0.18

# Vue édition de Joueur

Il nous faut une vue à afficher pour l'adresse `/players/3`.

Créez __src/Players/Edit.elm__ :

```elm
module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Players.Messages exposing (..)
import Players.Models exposing (..)


view : Player -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Player -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        []


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-plus-circle" ] [] ]
```

Cette vue montre un formulaire avec le niveau du Joueur. Pour l'instant, on a des boutons non fonctionnels (par exemple, `btnLevelIncrease`) qui seront implémentés plus tard.
