module Main exposing (main)

import Html exposing (..)
import Messages exposing (Msg(Login, OnLocationChange, SignUp))
import Models exposing (Model, initial)
import Navigation
import Pages
import Routes exposing (..)



main : Program Never Model Msg
main = Navigation.program OnLocationChange
        { init = \location -> ( {initial | route = parseLocation location }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


view : Model -> Html msg
view model =
    case model.route of
        HomeRoute -> Pages.landing model
        ReadPostRoute id -> Pages.readPost id model
        CreatePostRoute -> Pages.createPost model
        SignUpRoute -> Pages.signUp
        LoginRoute -> Pages.login
        ErrorRoute -> Pages.error "404 Not Found"


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        OnLocationChange location ->
            ({model | route = parseLocation location}, Cmd.none)
        OnEmailEntered email ->
        OnPasswordEntered psw ->
        OnRepeatEntered psw ->
        OnEmailEntered email ->
        Login user ->
            (model, Cmd.none)
        SignUp user ->
            (model, Cmd.none)
