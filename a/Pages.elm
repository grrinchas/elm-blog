module Pages exposing (..)

import Html exposing (Html)
import Models exposing (Model, Post, User)
import Components exposing (..)


header : User -> Html msg
header user =
    case user.logged of
        True ->
            userHeader user

        False ->
            authHeader


readPost : String -> Model -> Html msg
readPost id model =
    case List.head <| List.filter (\post -> post.id == id) model.posts of
        Just post ->
            layout (header model.user) (readPostBody post)

        Nothing ->
            error "404 Not Found"


createPost : Model -> Html msg
createPost model =
    layout (header model.user) (createPostBody)


landing : Model -> Html msg
landing model =
    layout (header model.user) (landingBody model.posts)


login : Html msg
login =
    Components.login


signUp : Html msg
signUp =
    Components.signUp


error: a -> Html msg
error err = Components.error err
