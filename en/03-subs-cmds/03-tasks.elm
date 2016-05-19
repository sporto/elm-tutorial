module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App
import Http
import Task
import Json.Decode as Decode

-- MODEL

type alias Model = String

init : (Model, Cmd Msg)
init =
  ("" , Cmd.none)

-- MESSAGES

type Msg
  = Fetch
  | FetchSuccess String
  | FetchError Http.Error

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Fetch ] [ text "Fetch" ]
    , text model ]

decode : Decode.Decoder String
decode =
  Decode.at ["name"] Decode.string

fetch : Cmd Msg
fetch =
  let
    url =
      "http://swapi.co/api/planets/1/"
  in
    Task.perform FetchError FetchSuccess (Http.get decode url)

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Fetch ->
      (model, fetch)
    FetchSuccess name ->
      (name, Cmd.none)
    FetchError _ ->
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