module Pages exposing (..)

import Html exposing (Html)
import Components exposing (..)
import Models exposing (..)


landing : Model -> Html msg
landing model =
    layout authHeader <| landingBody model.posts


readPost : String -> Model -> Html msg
readPost id model =
    case List.head <| List.filter (\post -> post.id == id) model.posts of
        Just post ->
            layout authHeader <| readPostBody post

        Nothing ->
            error "404 Not Found"

error : a -> Html msg
error err = Components.error err


createPost : Model -> Html msg
createPost model =
    layout (userHeader model.user) createPostBody


login : Model -> Html msg
login model = Components.login

signUp : Model -> Html msg
signUp model = Components.signUp
