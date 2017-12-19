module Pages exposing (..)

import Html exposing (Html)
import Components exposing (..)
import Models exposing (..)


landing : Model -> Html msg
landing model =
    layout authHeader <| landingBody model.posts
