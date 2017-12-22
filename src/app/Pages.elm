module Pages exposing (..)

import Html exposing (Html)
import Components exposing (..)
import Messages exposing (Msg)
import Models exposing (..)
import Routes exposing (..)


landing : Model -> Html Msg
landing model =
    Maybe.map userHeader model.user
        |> Maybe.withDefault authHeader
        |> flip layout (landingBody model.posts)


readPost : String -> Model -> Html Msg
readPost id model =
    case List.head <| List.filter (\post -> post.id == id) model.posts of
        Just post ->
            Maybe.map userHeader model.user
                |> Maybe.withDefault authHeader
                |> flip layout (readPostBody post)

        Nothing ->
            error "404 Not Found"


createPost : Model -> Html Msg
createPost model =
    case model.user of
        Just user ->
            layout (userHeader user) (createPostBody model.form)

        Nothing ->
            error "404 Not Found"


error : a -> Html msg
error err =
    Components.error err


login : Model -> Html Msg
login model =
    Components.login model.form


signUp : Model -> Html Msg
signUp model =
    Components.signUp model.form


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
