module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App

-- MODEL

type alias Model = String

init : (Model, Cmd Msg)
init =
  ("" , Cmd.none)

-- MESSAGES

type Msg
  = Fetch

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Fetch ] [ text "Fetch" ]
    , text model ]

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Fetch ->
      (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }