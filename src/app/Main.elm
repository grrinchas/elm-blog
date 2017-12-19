module Main exposing (main)

import Html exposing (program)
import Models exposing (..)
import Pages


main : Program Never Model msg
main = program
        { init = (initialModel, Cmd.none )
--      - view = Pages.landing
        , view =  Pages.readPost "3"
        , update = \msg model -> (model, Cmd.none)
        , subscriptions = \model -> Sub.none
        }







