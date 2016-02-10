# Adding a list of players

Let's create some content for our application.

## Players Model

Create __src/Players/Models.elm__

```elm
module Players.Models (..) where


type alias PlayerId =
  Int


type alias Player =
  { id : PlayerId
  , name : String
  , level : Int
  }


new : Player
new =
  { id = 0
  , name = ""
  , level = 1
  }
```

Here we define how a player record looks like, it has an id, a name and a level. 

Also note the definition for `PlayerId`, it is just an alias to `Int`, doing this is useful for clarity later on when we have function that take many ids. For example:

```elm
addPerkToPlayer : Int -> Int -> Player
```

is much clearer written as:

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## Players actions

Create __src/Players/Actions.elm__

```elm
module Players.Actions (..) where

import Http
import Players.Models exposing (PlayerId, Player)


type Action
  = NoOp
```

Here we will put all the actions related to players.

## Players List

Create __src/Players/List.elm__

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
    [ div
        [ class "right-align" ]
        []
    , table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Id" ]
                , th [] [ text "Name" ]
                , th [] [ text "Level" ]
                , th [] [ text "Bonus" ]
                , th [] [ text "Strengh" ]
                , th [] [ text "Actions" ]
                ]
            ]
        , tbody [] (List.map (playerRow address model) model.players)
        ]
    ]


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
          []
      ]
```

This view shows a list of users. 

#### ViewModel

This view expects a `ViewModel` as model. Why not simply pass a list of users? That would be fine for many cases, but often in your views you might need additional data. By creating a view model we allow space to evolve without having to refactor too much later.

Also note:

- `bonuses` is hardcoded to `999` for now, we will need to get this from other models.