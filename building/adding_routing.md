# Adding routing (WIP)

Let's add a router for our application. We will be using [Hop](https://github.com/sporto/hop) version 2.1.

## Routing

Create a module for defining the application routing configuration. In __src/Routing.elm__:

```elm
module Routing (..) where

import Effects exposing (Effects, Never)
import Hop


{-
Routing Actions

HopAction : is called after Hop has changed the location, we usually don't care about this action
ShowPlayers : Action that instructs to show the players page
EditPlayer : Action to show the Edit player page
ShowNotFound : Action that triggers when the browser location doesn't match any of our routes
NavigateTo : Action to change the browser location
-}


type Action
  = HopAction Hop.Action
  | ShowPlayers Hop.Payload
  | EditPlayer Hop.Payload
  | ShowNotFound Hop.Payload
  | NavigateTo String
  | NoOp



{-
Available views in our application
NotFoundView is necessary when no route matches the location
-}


type AvailableViews
  = PlayersView
  | EditPlayerView
  | NotFoundView



{-
We need to store the payload given by Hop
And we store the current view
-}


type alias Model =
  { routerPayload : Hop.Payload
  , view : AvailableViews
  }


initialModel : Model
initialModel =
  { routerPayload = router.payload
  , view = PlayersView
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    {-
    NavigateTo
    Called from our application views e.g. by clicking on a button
    asks Hop to change the page location
    -}
    NavigateTo path ->
      ( model, Effects.map HopAction (Hop.navigateTo path) )

    {-
    ShowPlayers and EditPlayer
    Actions called after a location change happens
    these are triggered by Hop
    -}
    ShowPlayers payload ->
      ( { model | view = PlayersView, routerPayload = payload }, Effects.none )

    EditPlayer payload ->
      ( { model | view = EditPlayerView, routerPayload = payload }, Effects.none )

    _ ->
      ( model, Effects.none )



{-
Routes in our application
Each route maps to a view
-}


routes : List ( String, Hop.Payload -> Action )
routes =
  [ ( "/", ShowPlayers )
  , ( "/players", ShowPlayers )
  , ( "/players/:id/edit", EditPlayer )
  ]



{-
Create a Hop router
Hop expects the a list of routes and an action for a location doesn't match
-}


router : Hop.Router Action
router =
  Hop.new
    { routes = routes
    , notFoundAction = ShowNotFound
    }


```

The code should be clear from the comments. In this module we:

- define actions that can happen when a location changes, see `Action`
- define available views, see `AvailableViews`
- define how to react to the actions, see `update`
- define how browser locations map to actions, see `routes`.

## Main Model

The main application model needs to be change to include the routing model. Change __src/Model.elm__ to:

```elm
module Models (..) where

import Players.Models exposing (Player)
import Routing


type alias AppModel =
  { players : List Player
  , routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  { players = [ Player 1 "Sam" 1 ]
  , routing = Routing.initialModel
  }
```

## Main Actions

In __src/Actions.elm__ we need to add a new action so we can route actions coming from the router:

```elm
module Actions (..) where

import Players.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | PlayersAction Players.Actions.Action
```

## Main Update

__src/Update.elm__ also needs to account for the newly added action:

```elm
module Update (..) where

import Effects exposing (Effects)
import Debug
import Models exposing (..)
import Actions exposing (..)
import Routing
import Players.Update


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case (Debug.log "action" action) of
    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing
      in
        ( { model | routing = updatedRouting }, Effects.map RoutingAction fx )

    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players
          }

        ( updatedPlayers, fx ) =
          Players.Update.update subAction updateModel
      in
        ( { model | players = updatedPlayers }, Effects.map PlayersAction fx )

    NoOp ->
      ( model, Effects.none )
```

Here we added `RoutingAction`. We follow the same pattern as before and send those actions to the `Routing` module and then replace `.routing` in our main model.

## Main View

Our main application view needs to show different pages as we change the browser location. Change __src/View.elm__ to:

```elm
module View (..) where

import Html exposing (..)
import Dict
import Actions exposing (..)
import Models exposing (..)
import Routing
import Players.List
import Players.Edit


view : Signal.Address Action -> AppModel -> Html
view address model =
  let
    _ =
      Debug.log "model" model
  in
    div
      []
      [ page address model ]


page : Signal.Address Action -> AppModel -> Html.Html
page address model =
  case model.routing.view of
    Routing.PlayersView ->
      let
        viewModel =
          { players = model.players
          }
      in
        Players.List.view (Signal.forwardTo address PlayersAction) viewModel

    Routing.PlayerEditView ->
      let
        playerId =
          model.routing.routerPayload.params
            |> Dict.get "id"
            |> Maybe.withDefault ""

        maybePlayer =
          model.players
            |> List.filter (\player -> (toString player.id) == playerId)
            |> List.head
      in
        case maybePlayer of
          Just player ->
            let
              viewModel =
                { player = player
                }
            in
              Players.Edit.view (Signal.forwardTo address PlayersAction) viewModel

          Nothing ->
            notFoundView

    Routing.NotFoundView ->
      notFoundView


notFoundView : Html.Html
notFoundView =
  div
    []
    [ text "Not found"
    ]
```

- Now we have a function `page` which has a case expression to show the correct view dependending on what is in `model.routing.view`.
- When hitting the edit player view (e.g. `/players/3/edit`) we may or may not have a player with that id. 
    -  We get the `id` from `model.routing.routerPayload.params`.
    -  Then we filter the `model.players` collection to find that id.
    -  Then we add a case expression that either shows the edit view or a 'not found view' if the player is not found.

---

## Edit Player View

We need a new view to show when hitting `/players/3/edit`. Create __src/Players/Edit/elm__:



## Players Update







