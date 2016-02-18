# Players List

Create __src/Players/List.elm__

<https://github.com/sporto/elm-tutorial-app/blob/100-players/src/Players/List.elm>

```elm
module Players.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Players.Actions exposing (..)
import Players.Models exposing (Player)


type alias ViewModel =
  { players : List Player
  }


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div
    []
    [ nav address model
    , list address model
    ]


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Players" ] ]


list : Signal.Address Action -> ViewModel -> Html.Html
list address model =
  div
    []
    [ table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Id" ]
                , th [] [ text "Name" ]
                , th [] [ text "Level" ]
                , th [] [ text "Actions" ]
                ]
            ]
        , tbody [] (List.map (playerRow address model) model.players)
        ]
    ]


playerRow : Signal.Address Action -> ViewModel -> Player -> Html.Html
playerRow address model player =
  tr
    []
    [ td [] [ text (toString player.id) ]
    , td [] [ text player.name ]
    , td [] [ text (toString player.level) ]
    , td
        []
        []
    ]
```

This view shows a list of users. 

#### ViewModel

This view expects a `ViewModel` as model. Why not just pass a list of users? That would be fine for many cases, but often in your views you might need additional data. By creating a view model we allow space to evolve without having to refactor too much later.
