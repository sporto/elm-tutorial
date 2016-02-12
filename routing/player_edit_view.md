# Player edit view

## Edit Player View

We need a new view to show when hitting `/players/3/edit`. Create __src/Players/Edit/elm__:

```elm
module Players.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Players.Models exposing (..)
import Players.Actions exposing (..)


type alias ViewModel =
  { player : Player
  }


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div
    []
    [ nav address model
    , form address model
    ]


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    [ a [ class "btn button-narrow", href "#/players" ] [ i [ class "fa fa-chevron-left" ] [], text " Players" ]
    ]


form : Signal.Address Action -> ViewModel -> Html.Html
form address model =
  let
    bonuses =
      999

    strength =
      model.player.level + bonuses
  in
    div
      [ class "m3" ]
      [ h1 [] [ text model.player.name ]
      , formLevel address model
      , formBonuses bonuses
      , formStrength strength
      , formName address model
      , formPerks address model
      ]


formLevel : Signal.Address Action -> ViewModel -> Html.Html
formLevel address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Level" ]
    , div
        [ class "col col-7" ]
        [ span [ class "h2 bold" ] [ text (toString model.player.level) ]
        , btnLevelDecrease address model
        , btnLevelIncrease address model
        ]
    ]


btnLevelDecrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelDecrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Signal.Address Action -> ViewModel -> Html.Html
btnLevelIncrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i [ class "fa fa-plus-circle" ] [] ]


formBonuses : Int -> Html.Html
formBonuses bonuses =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text "Bonuses" ]
    , div [ class "col col-7 h2" ] [ text (toString bonuses) ]
    ]


formStrength : Int -> Html.Html
formStrength strength =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text "Strength" ]
    , div [ class "col col-7 h2 bold" ] [ text (toString strength) ]
    ]


formName : Signal.Address Action -> ViewModel -> Html.Html
formName address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Name" ]
    , div
        [ class "col col-7" ]
        [ inputName address model
        ]
    ]


inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input
    [ class "field-light"
    , value model.player.name
    ]
    []


formPerks : Signal.Address Action -> ViewModel -> Html.Html
formPerks address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Perks" ]
    , div
        [ class "col col-7" ]
        []
    ]
```

This view show a form with player's:

- level
- total bonus
- total strength
- name
- and a space for associated perks

As we did before `bonuses` is just hard coded to `999` for now.

There is one important line in the `nav` function above:

```elm
a [ class "btn button-narrow", href "#/players" ] [ i [ class "fa fa-chevron-left" ] [], text " Players" ]
```

Here we have a link that will trigger a browser location change thus showing the players' list again.



## Players List

The players' list needs to show a button for each player in order to go to that player's edit view. 

In __src/Players/List.elm__. Add a new function for this button at the end:

```elm
editBtn : Signal.Address Action -> Player -> Html.Html
editBtn address player =
  button
    [ class "btn regular"
    , onClick address (EditPlayer player.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
```

Here we trigger `EditPlayer` with the id of the player that we want to edit.

And change `playersRow` to include this button:

```elm
playerRow : Signal.Address Action -> ViewModel -> Player -> Html.Html
playerRow address model player =
  let
    bonuses =
      999

    strength =
      bonuses + player.level
  in
    tr
      []
      [ td [] [ text (toString player.id) ]
      , td [] [ text player.name ]
      , td [] [ text (toString player.level) ]
      , td [] [ text (toString bonuses) ]
      , td [] [ text (toString strength) ]
      , td
          []
          [ editBtn address player ]
      ]
```

