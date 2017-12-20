module Main exposing (main)

import Messages exposing (..)
import Models exposing (..)
import Navigation
import Pages
import Routes exposing (parseLocation, path)


{-

main : Program Never Model msg
main = program
        { init = (initialModel, Cmd.none )
        , view =  Pages.landing
        , update = \msg model -> (model, Cmd.none)
        , subscriptions = \model -> Sub.none
        }
-}

main : Program Never Model Msg
main = Navigation.program OnLocationChange
        { init = \location -> ({initialModel | route = parseLocation location}, Cmd.none )
        , view =  Pages.view
        , update = update
        , subscriptions = \model -> Sub.none
        }


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        OnLocationChange location ->
            ({model| route = parseLocation location}, Cmd.none)
        UpdateRoute route ->
            (model, Navigation.newUrl <| path route)












