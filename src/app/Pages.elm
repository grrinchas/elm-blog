module Pages exposing (..)

import Html exposing (Html)
import Components exposing (..)
import Messages exposing (Msg)
import Models exposing (..)
import Routes exposing (..)


landing : Model -> Html Msg
landing model =
    --  layout authHeader <| landingBody model.posts
    Maybe.map userHeader model.user
        |> Maybe.withDefault authHeader
        |> flip layout (landingBody model.posts)


readPost : String -> Model -> Html msg
readPost id model =
    case List.head <| List.filter (\post -> post.id == id) model.posts of
        Just post ->
            --          layout authHeader <| readPostBody post
            Maybe.map userHeader model.user
                |> Maybe.withDefault authHeader
                |> flip layout (readPostBody post)

        Nothing ->
            error "404 Not Found"


error : a -> Html msg
error err =
    Components.error err


createPost : Model -> Html msg
createPost model =
    --  layout (userHeader model.user) createPostBody
    case model.user of
        Just user ->
            layout (userHeader user) createPostBody

        Nothing ->
            error "404 Not Found"


login : Model -> Html msg
login model =
    Components.login


signUp : Model -> Html msg
signUp model =
    Components.signUp


view : Model -> Html Msg
view model =
    case model.route of
        HomeRoute ->
            landing model

        ReadPostRoute id ->
            readPost id model

        CreatePostRoute ->
            createPost model

        LoginRoute ->
            login model

        SignUpRoute ->
            signUp model

        ErrorRoute ->
            error "404 Not Found"
